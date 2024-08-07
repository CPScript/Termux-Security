# VPN.sh Notes:

---

## Introduction
* This script provides a simple and user-friendly way to configure and connect to a VPN using OpenVPN. It uses the npyscreen library to create a text-based user interface, making it easy to navigate and configure your VPN settings.

## How it Works
The script creates a text-based user interface with fields for:
* Server address
* Port
* Username
* Password
* Static IP
* VPN type (OpenVPN, L2TP, PPTP)

1. The user fills in the required fields and selects the VPN type.
2. The script generates a configuration file based on the user's input and saves it to a specified directory.
3. The user can then select the generated configuration file to connect to the VPN using OpenVPN.
