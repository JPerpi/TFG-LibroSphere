// Importamos las bibliotecas ExpressJS y body-parser
import express from 'express';
import controllers from './controllers/controllersBiblio.js';
// import{getTipos, getLibros, getDetalls} from "./Models/tipo.js";

import bodyParser from 'body-parser';
const { urlencoded, json } = bodyParser;
// Definimos app como una aplicación express, invocando a su constuctor.
const app = express();

// Configuramos la aplicación para que descodifique 
// las peticiones del cliente y las pase a JSON.
app.use(urlencoded({ extended: true }));
app.use(json());

// Configuramos el servidor para escuchar por el puerto  8080
// Observad que el primer argumento es el puerto y el segundo
// es un callback que se lanza cuando se ha iniciado el servidor.
app.listen(8080, () => {
    console.log('Escuchando por el puerto 8080')
});

function DefaultController(req, res) {
    res.send('Error 404. Not Found');
}

//Router
const router = express.Router();
router.get('/tipos',controllers.obtenerTipo)
router.get('/libros/:tipo?',controllers.obtenerLibrosTipo)
router.get('/detalles/:libro?',controllers.obtenerLibro)


app.use("/api/biblioteca",router)
app.use("*",DefaultController)
