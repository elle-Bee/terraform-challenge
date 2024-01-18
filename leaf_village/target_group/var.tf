
variable "applicaton_name" {
  type = string
}
variable "applicaton_port" {
  type = bool
  default = 80
}
variable "applicaton_health_check_target" {
  type = string
  default = "/"
}
variable "tg_target_type" {
  type = string
  default = ""instance""
}
variable "tg_protocol" {
  type = string
  default = "HTTP"
}
variable "vpc_id" {
  type = string
}
