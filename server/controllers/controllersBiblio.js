import{getTipos, getLibros, getDetalls} from "../Models/tipo.js";

export default class controllersBiblio {
    static obtenerTipo(req, res) {
        res.send(getTipos())
    }

    static obtenerLibrosTipo(req, res) {
        res.send(getLibros(req.params.tipo))
    }

    static obtenerLibro(req, res) {
        res.send(getDetalls(req.params.libro))
    }
}