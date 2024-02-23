variable "vpccidr" {
  type = string
}
variable "sunetcidr" {
  type = string
}
variable "instancetype" {
  type = string
}
variable "ami" {
  type = string
  default = "ami-03f4878755434977f"
}
variable "keypair" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCrleFPRAlYWMm6hl5qAN+KmwjOHIUh+lG1stT52g19j1if8Cfj3u9aEv5YP0UHyvdg2+dbwFqU8SAMkdpkcEtNHzyylw6miA4sPUwSANDbExwRW1A8WY+SwEC202k/cYgnUXw1QyC/9mlBgjFG+d/PzEKjKQOTV0f2Iz7PaFagB6nucYpDplxJDu5YrxzJ3msjb5xf7HADKuna6RBF9lM8oNFViQF0PW44offR965TVVc4Z/jJSAl4gjq7UhFbEubsgQXAtl+JJGlDbLDOaf+7NHsgWweBKrzeF2O7QRdRCPdOCuDMrAqJmsrh9cgXfZzDnSkxU0avS31c1ujqqAnW6if4HHGxJARKiX1iaPzaBmApBdFnnglBp7BrGuDrhHYVoIZKaJcwC/J78u8ZkW+gpdW7XlG991rWcMyxzkkGFBbDgKL9YWjkOPzFqiGrxbUIAeQrrFypJo6T9AQeb+pODUxLBkZKoCatGNMjgF65S9HqItfVlYdijwormVZFIfk= 91790@Anitha"
}