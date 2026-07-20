# Milestone 01: Home Wireless Infrastructure Mesh Migration

## Executive Summary
[Copy and paste your catchy LinkedIn introduction here! State what the project was, why you did it, and the ultimate high-level result.]

## The Problem & Motivation
* **The Legacy Setup:** [Briefly describe what you had before—e.g., standard ISP router in the living room.]
* **The Issues:** [Explain the pain points—e.g., dead zones in the office, high latency during SSH connections, or poor throughput.]
* **Objective:** Establish a seamless wireless roaming matrix across the entire living space to support a virtualization homelab environment.

## Physical Network Architecture
* **Hardware Deployed:** [List the specific brand/model of your new mesh nodes.]
* **Placement Strategy:** [Briefly explain where you placed them and why to optimize coverage between the living room and office.]

## Telemetry & Performance Metrics (Before vs. After)
To validate the migration, throughput testing was conducted on [Name of your testing device] before and after the deployment.

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
