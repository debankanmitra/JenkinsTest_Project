# React + Vite

This template provides a minimal setup to get React working in Vite with HMR and some ESLint rules.

Currently, two official plugins are available:

- [@vitejs/plugin-react](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react/README.md) uses [Babel](https://babeljs.io/) for Fast Refresh
- [@vitejs/plugin-react-swc](https://github.com/vitejs/vite-plugin-react-swc) uses [SWC](https://swc.rs/) for Fast Refresh

In CI we do both build as well as also create docker image , we first build the application application ex: "npm run build" and after that package the application in a docker image and push it into docker repository


FROM , LABEL , ENV , 
RUN - multiple run command shouldn't be used because in some cases when we download something and later we delete that, it still kept lying around in underlyinfg layers causing bigger image size , and also docker has layer limit of 127 layers so we shouldn't use somany RUN (https://youtu.be/EmCRj5O4UZE?t=439)
WORKDIR - change work dir use to define directory inside the container, 
USER name - change user in linux ,
COPY, ADD - extract the files or link then copy it to the specified folder , CMD , EXPOSE - expose port
ENTRYPOINT instruction is used to configure the executables that will always run after the container is initiated. For example, you can mention a script to run as soon as the container is started.