# Asynchronous FIFO

## Overview
An **Asynchronous FIFO (First-In-First-Out)** is a memory buffer used to transfer data between two clock domains operating at **different clock frequencies**. It allows reliable communication between modules that do not share the same clock signal.

This implementation uses **dual-port memory**, **Gray code pointers**, and **pointer synchronization** to safely perform clock domain crossing (CDC).

---

## Features
- Independent **read and write clocks**
- **Dual-port memory** for simultaneous read and write
- **Gray code pointer synchronization** to prevent metastability
- **Full and empty flag detection**
- Parameterizable **data width and FIFO depth**

---

## Architecture

The asynchronous FIFO consists of the following main components:

1. **Write Pointer Logic**
2. **Read Pointer Logic**
3. **Memory Array**
4. **Pointer Synchronizers**
5. **Full and Empty Detection Logic**

Data flow:
<p align="center">
  <img src="images/fifo.png" width="500"/>
</p>
