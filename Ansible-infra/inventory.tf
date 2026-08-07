locals {
  inventory_content = templatefile("${path.module}/templates/inventory.tftpl", {
    ssh_user         = var.ssh_user
    private_key_path = var.private_key_path

    controller = {
      name       = aws_instance.controller.tags["Name"]
      public_ip  = aws_instance.controller.public_ip
      private_ip = aws_instance.controller.private_ip
    }

    nodes = [
      for vm in aws_instance.node : {
        name       = vm.tags["Name"]
        public_ip  = vm.public_ip
        private_ip = vm.private_ip
      }
    ]
  })
}

resource "local_file" "inventory" {
  content         = local.inventory_content
  filename        = var.inventory_path
  file_permission = "0644"

}
