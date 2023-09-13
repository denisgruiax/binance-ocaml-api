# Binance Ocaml API
A lightweight OCaml library for interacting with the Binance API.
## Warning. ⚠️
**I do not guarantee the correctness of the code!** ❌

## Credits. ⭐
- 🧑‍💻 Professor Michael R. Clarkson - https://cs3110.github.io/textbook/cover.html

- 🧑‍💻 Professor Marius Minea - http://staff.cs.upt.ro/~marius/curs/lsd/index.html

## About the project. 🪴
### Purpose 🎯
The purpose of the library is really only for trading and not to implement the entire API of the Binance platform. The library will grow over time and primarily implement APIs for trading on Future and Spot accounts.

To build the entire Binance API in Ocaml will take a lot of time and effort, and first of all I need the transaction placement APIs for some private projects in Ocaml.

After these, the rest of the APIs can be implemented.

### Built With. ⚒️
The programs can be build with Dune build system and Ocaml compiler (native or bytecode compiler). 🐪

## Getting Started. 🚀
### System requirements ✅
- Operating System: MacOS, Linux(Ubuntu for example), Windows Subsystem for Linux. (WSL) // I do not recommend installing on Windows, it is not natively supported.
- Package Manager: Opam for Ocaml programming language and other packages.
- Programming Language: Ocaml
- Code Editor: Visual Studio Code 

Personally, I made use of WSL with Visual Studio Code, and most of time i used the ocaml interpreter to evaluate my programs for single file programs. Now if you want run, test and debug the library you must make use of Dune commands. (dune build, dune exec project, dune test)

### Installation. 🪜
1. Install opam and ocaml
   ```sh
   https://ocaml.org/docs/up-and-running
   ```

2. Install OCAML packages
   ```sh
   opam install merlin ocp-ident lwt domainslib ezjsonm cohttp cohttp-lwt tls ssl
   ```
   
3. Configure Visual Studio Code to run OCaml code.
   ```sh
   Install OCaml extenions from VSCode marketplace.
   ```
   
   ```sh
   I had to change the setting "ocaml.merlinPath": "ocamlmerlin", in the OCaml VSCode extension settings to "ocaml.merlinPath": "ocamlmerlin-server", to get the extension to work.
   ```

## Learning. 🌟
**https://cs3110.github.io/textbook/cover.html**

**http://staff.cs.upt.ro/~marius/curs/lsd/index.html**

**http://labs.cs.upt.ro/~oose/pmwiki.php/LSD/LogicaSiStructuriDiscrete**

https://dev.realworldocaml.org/

https://www.greenteapress.com/thinkocaml/index.html

https://ocaml.github.io/ocamlunix/index.html

http://pauillac.inria.fr/~ddr/

https://mukulrathi.com/ocaml-tooling-dune/

## Contributing. 🏗️
Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


## Contact. ✉️
**Denis Gruia**

- Twitter - [@denisgruiax](https://twitter.com/denisgruiax) 
- Email - denis.gruiax@icloud.com
- Project Link - [https://github.com/denisgruiax](https://github.com/denisgruiax)