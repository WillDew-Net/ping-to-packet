# Milestone 01: Home Wireless Infrastructure Mesh Migration

## Executive Summary
Moving into a new home always comes with unique challenges. In my case, a single upstairs coaxial port meant my gateway router was bottlenecked on the top floor. This caused severe Wi-Fi dropouts and massive throughput loss downstairs in my office space.

Instead of just accepting a weak signal, I decided to treat this as a hands-on extension of my IT networking studies!

## The Problem & Motivation
* **The Legacy Setup:** Initially, my network consisted of an xfinity gateway with all devices connected to it wirelessly. 
* **The Issues:** Due to the gateway being upstairs, the signal would degrade significantly as it tried to penetrate walls and floors using the 5Ghz frequency band. This prevented me from being able to stream shows in the living room, play online games in my office, or build out my homelab. I cosidered hiring an electrician to add a coaxial port downstairs, but the quote I received was expensive and likely would have just moved my deadzone from dowwnstairs to upstairs. I'd hardly consider that a solution.
* **Objective:** Upgrade my home network to allow device connectivity throughout my home. Devices should be able to connect to the internet no matter where they're located in my house, as long as they're connected to my network. 

## Physical Network Architecture
* **Hardware Deployed:** Deco Wi-Fi 7 BE11000 Tri-Band Mesh System
* **Placement Strategy:** I purposely ordered a pack of 3 mesh nodes to tackle the main pain points of the signal degredation. Plugging my main mesh node into the gateway allowed that original signal to pass on to the mesh node, allowing the main node to essentially replace the original gateway. From there, the additional nodes spread throughout my home could connect to the main node using the 5GHz and 6GHz frequency bands. Wi-Fi 7 hardware has better antennas and can push signals on these bands through obstacles with little issue, so the slower 2.4GHz band isn't the only option for node-to-node communication through obstructions. Now when devices connect to the nearest (strongest) mesh node, they don't have to send data through so many layers of building material. Data is sent from the device to the nearby node, and then that data is adequately transmitted to the main node using the 2.4GHz, 5GHz, and 6GHz bands with data packets split between each band. In addition, the mesh nodes come with ethernet ports and I was able to create a small LAN in my office space for my homelab 

## Telemetry & Performance Metrics (Before vs. After)
To validate the migration, throughput testing was conducted on playstation 5 before and after the deployment.

| Metric | Legacy ISP Router | New Mesh Infrastructure | Delta (%) |
| :--- | :--- | :--- | :--- |
| **Download Speed** | XX.X Mbps | XX.X Mbps | +XX% |
| **Upload Speed** | XX.X Mbps | XX.X Mbps | +XX% |
| **Ping / Latency** | XX ms | X ms | -XX% |

> 💡 *Note: Detailed screenshots of these speed test variations can be found in the `images/` directory.*

## Logical Topology Replica (Cisco Packet Tracer)
To maintain architectural visibility, I modeled the logical deployment using Cisco Packet Tracer. This topology mirrors the physical routing, DHCP pool boundaries, and node relationships.

![Network Topology](./images/your_packet_tracer_export.png)
*You can access and interact with the live lab file here: `topology.pkt`*

## Key Engineering Takeaways
* **Roaming & Handoff:** Learned how 802.11k/v/r protocols (or standard mesh roaming) handle active client handoffs between nodes seamlessly compared to traditional range extenders.
* **Lab Impact:** This infrastructure stabilizes the wireless bridge required to manage the Proxmox hypervisor host remotely via SSH from my workstation and laptops.

---
*As originally shared on my [LinkedIn Profile](URL_TO_YOUR_POST).*
