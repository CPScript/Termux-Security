import npyscreen
import os
import glob

CONFIG_DIR = "vpn_configs"

class VPNConfigForm(npyscreen.FormBaseNew):
    def create(self):
        self.name = "VPN Configuration"
        
        self.server = self.add(npyscreen.TitleText, name="Server Address:", value="")
        self.port = self.add(npyscreen.TitleText, name="Port:", value="1194")
        self.username = self.add(npyscreen.TitleText, name="Username:", value="")
        self.password = self.add(npyscreen.TitlePassword, name="Password:", value="")
        self.static_ip = self.add(npyscreen.TitleText, name="Static IP:", value="")
        self.vpn_type = self.add(npyscreen.TitleSelectOne, max_height=4, value=[0,], name="VPN Type",
                                 values=["OpenVPN", "L2TP", "PPTP"], scroll_exit=True)
        
        self.config_files = self.get_config_files()
        self.config_choice = self.add(npyscreen.TitleSelectOne, max_height=4, value=[0,], name="Config File",
                                      values=self.config_files, scroll_exit=True)
        self.add(npyscreen.ButtonPress, name="Save Config", when_pressed_function=self.save_config)
        self.add(npyscreen.ButtonPress, name="Connect", when_pressed_function=self.connect_to_vpn)

    def get_config_files(self):
        if not os.path.exists(CONFIG_DIR):
            os.makedirs(CONFIG_DIR)
        return glob.glob(f"{CONFIG_DIR}/*.ovpn")

    def save_config(self):
        server = self.server.value
        port = self.port.value
        username = self.username.value
        password = self.password.value
        static_ip = self.static_ip.value
        vpn_type = self.vpn_type.get_selected_objects()[0]
        
        config_content = f"""
client
dev tun
proto udp
remote {server} {port}
resolv-retry infinite
nobind
persist-key
persist-tun
remote-cert-tls server
auth-user-pass credentials.txt
ifconfig {static_ip} 255.255.255.0
route {static_ip} 255.255.255.0
cipher AES-256-CBC
verb 3
        """
        
        config_name = f"{CONFIG_DIR}/{server}_{port}_{vpn_type}.ovpn"
        with open(config_name, "w") as f:
            f.write(config_content)
        
        # Save temp file(s)
        with open("credentials.txt", "w") as f:
            f.write(f"{username}\n{password}\n")
        
        npyscreen.notify_confirm(f"Configuration saved as {config_name}", title="Success")

    def connect_to_vpn(self):
        selected_config = self.config_files[self.config_choice.value[0]]
        
        # Start openvpn
        os.system(f"openvpn --config {selected_config}")

class VPNApp(npyscreen.NPSAppManaged):
    def onStart(self):
        self.addForm("MAIN", VPNConfigForm)

if __name__ == "__main__":
    app = VPNA
