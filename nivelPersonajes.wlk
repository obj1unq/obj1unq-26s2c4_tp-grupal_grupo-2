

class Nivel {

    var property nivel
    var property danio

    method perderEnergia(personaje){
        personaje.perderEnergia(danio)
    }
}



var nivelGuerrero1  = new Nivel(nivel = "1", danio = 2)
var nivelGoblin1    = new Nivel(nivel = "1", danio = 1)

//nivel 2....
//nivel 3....