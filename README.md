# High-Performance Pipelined Block Cipher Implementation

## Project Overview
This project features a high-throughput hardware implementation of a Block Cipher optimized for the **Advanced Encryption Standard (AES)**. The design focuses on minimizing area and maximizing frequency by replacing traditional, resource-heavy Look-Up Tables (LUTs) with a purely combinational **Galois Field $GF(2^4)$** arithmetic architecture for the S-Box.

The system is fully pipelined, operating at a **100 MHz clock frequency**, and is capable of processing data with a minimal latency of only **2 clock cycles**.

## Architecture & Features

### 1. Optimized S-Box (Confusion Layer)
Instead of using a static ROM-based S-Box, this design implements the S-Box "on-the-fly" based on the research by *Phuc-Phan Duong et al.* This approach utilizes **Composite Field Arithmetic** to perform 8-bit inversions in $GF(2^8)$ by decomposing them into smaller, more efficient $GF(2^4)$ operations.
* **Benefit:** Significant reduction in Silicon area and power consumption compared to standard LUT-based designs.
* **Security:** Provides the necessary non-linearity for robust encryption.



### 2. P-Box (Diffusion Layer)
The P-Box implements the diffusion property by performing bit-level permutations and shifts. This ensures that the influence of a single input bit is spread across the entire block, frustrating statistical analysis.

### 3. Key Generation & LFSR
For the encryption keying material, the design incorporates a Linear Feedback Shift Register (LFSR) utilizing the polynomial $x^7 + x^4 + x^3 + x^2 + 1$. 
* **Function:** Generates a pseudo-random sequence to be XORed with the input data (e.g., audio streams).
* **Performance:** The sequence is tuned to provide high-speed key stream generation synchronized with the data path.

### 4. Hardware Pipelining & Performance
The architecture is designed for high-speed RTL synthesis:
* **Clock Frequency:** 100 MHz.
* **Latency:** 2-cycle throughput.
* **Critical Path Optimization:** The combinational logic between registers was meticulously balanced to minimize propagation delay, allowing for high-frequency operation without timing violations.

## Design Hierarchy
* `file_reader.v`: Handles input data ingestion for simulation environments.
* `lfsr.v`: The pseudo-random generator with a primitive polynomial which repeates sequence 82-cycles.
* `sbox.v`: The Galois Field-based confusion module.
* `pbox.v`: Bit-permutation and data scrambling logic.
* `block_cipher_top.v`: The top-level module integrating the pipeline stages.

## Micro-Architecture 

![WhatsApp Image 2026-02-24 at 10 38 15 AM](https://github.com/user-attachments/assets/dbcb4983-b818-4cd2-a414-6bcebdfcc04a)

## References
* *Duong, P. P., et al.* "Compact 8-Bit S-Boxes Based on Multiplication in a Galois Field GF(2^4)."
* *Design and Implementation of Efficient Block Cipher* (General Architecture Reference).
