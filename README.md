# Oceania 🌊

The Oceania program is a command-line utility that monitors running Docker containers and displays their status in a colored dot format. It was originally created in 2017, and later ported to Go in 2023 by me. Really cringe for something so simple.

## Installation

To install Oceania, follow these steps:

1. Install Go by following the instructions on the official Go website: https://golang.org/doc/install

2. Download the Oceania source code:

```bash
git clone https://github.com/username/oceania.git
```

3. Navigate to the Oceania directory:

```bash
cd oceania
```

4. Build the Oceania binary:

```bash
make build
```

5. Installation steps coming soon. I have to polish the Makefile.

## 📊 Usage

To use Oceania, simply run the `oceania` command in your terminal:

```bash
./oceania
```

When you run Oceania, it will display a list of all running Docker containers on your system along with their status:

🟢 Green: container is running
🔴 Red: container has exited
🟡 Yellow: container is in a paused / degraded state

## 🤝 Contributing
If you have any suggestions for improving Oceania, feel free to submit a pull request. I'm always happy to receive contributions from y'all!

## 📄 License
Oceania is released under the GPL-3 License. See LICENSE for more information.
