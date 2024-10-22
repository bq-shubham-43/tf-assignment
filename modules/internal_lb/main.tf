
resource "google_compute_subnetwork" "reserved_subnet" {
  name          = "${var.vpc_name}-reserved-subnet"
  provider      = google-beta
  ip_cidr_range = var.reserved_subnet_ip_range
  region        = var.region
  network       = var.vpc_id
  purpose       = "REGIONAL_MANAGED_PROXY"  # For an internal load balancer
  role          = "ACTIVE"
}

resource "google_compute_region_backend_service" "internal_backend" {
  name                  = "internal-backend-${var.vpc_name}"
  load_balancing_scheme = "INTERNAL_MANAGED"
  protocol              = "HTTP"  # Set to HTTP for the backend service
  region = var.region
  timeout_sec           = 10

  backend {
    group = var.instance_group_name
    balancing_mode = "UTILIZATION"
    capacity_scaler = 1.0
  }

  health_checks = [google_compute_health_check.internal_health_check.self_link]
}

resource "google_compute_health_check" "internal_health_check" {
  name               = "internal-health-check-${var.vpc_name}"
  check_interval_sec = 10
  timeout_sec        = 5
  healthy_threshold  = 2
  unhealthy_threshold = 2

  http_health_check {
    port        = 80 
    request_path = "/"
  }
}

resource "google_compute_region_url_map" "internal_url_map" {
  name            = "internal-url-map-${var.vpc_name}"
  default_service = google_compute_region_backend_service.internal_backend.self_link
}

resource "google_compute_region_target_http_proxy" "internal_http_proxy" {
  name    = "internal-http-proxy-${var.vpc_name}"
  url_map = google_compute_region_url_map.internal_url_map.self_link
}

resource "google_compute_forwarding_rule" "ilb_forwarding_rule" {
  name            = "internal-lb-${var.vpc_name}"
  provider              = google-beta
  target          = google_compute_region_target_http_proxy.internal_http_proxy.self_link 
  port_range      = "80"
  ip_protocol           = "TCP"
  load_balancing_scheme = "INTERNAL_MANAGED"
  network = var.vpc_id
  region = var.region
  subnetwork      = var.subnet_id
  depends_on      = [google_compute_subnetwork.reserved_subnet]
  network_tier          = "PREMIUM"
}

resource "google_compute_address" "internal_lb_ip" {
  name   = "ilb-ip-${var.vpc_name}"
  region = var.region
}