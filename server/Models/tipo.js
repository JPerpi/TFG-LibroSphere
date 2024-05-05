import fs from "fs";

export let tipos= JSON.parse(fs.readFileSync("./Models/tipos.json","utf-8"));
export let libros= JSON.parse(fs.readFileSync("./Models/libros.json", "utf-8"));
export let detalls= JSON.parse(fs.readFileSync("./Models/detalles.json","utf-8"));

export function getTipos(){
    return tipos ;
}

export function getLibros(tipo){
    let llistaLibros=[]
    for (let libro of libros){
        if (tipo == libro.tipo){
            llistaLibros.push(libro)
        }
    }
    return llistaLibros;
}

export function getDetalls(libro){
    let llistaDetall=[]
    for (let detall of detalls){
        if (libro == detall.titulo){
            llistaDetall.push(detall)
        }
    }
    return llistaDetall;
}