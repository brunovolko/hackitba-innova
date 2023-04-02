# HackITBA - Equipo Innova - Proyecto Equigive

## Resumen
Una solución agnóstica, inteligente, diversificada, transparente y equitativa traducida en paquetes de donaciones para eliminar la friccion en los procesos de donacion tradicionales.

## Infraestructura del MVP
La plataforma consta de un front-end (sin framework) y un smart contract deployado en una blockchain EVM local (por ejemplo Ganache).

## Instrucciones para ejecutar el proyecto
1. Ejecutar blockchain local. Para la demo se usó Ganache y por lo tanto se recomienda utilizar la misma herramienta.
2. Hacer deploy del smart contract (contract/Equigive.sol) a la red local. Puede ser usando [Remix](https://remix.ethereum.org) y configurando la red como "Custom" y especificando la dirección local que proporciona Ganache (o similar).
3. Configurar un servidor para exponer el front-end. Es importante no acceder directamente a los html ya que Metamask requiere que sea una conexión HTTP. Para ello recomendamos utilizar la extensión de VSCode llamada "Live Server".
4. Acceder a la web mediante un navegador con MetaMask que a su vez tenga conexión a la red local Ganache.


## Integrantes del equipo
- Ariel Reznik
- Micaela Obadia
- Bruno Volcovinsky