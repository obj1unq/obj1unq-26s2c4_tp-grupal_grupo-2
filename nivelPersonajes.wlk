

class Nivel {

    var property nivel
    var property danio

    method perderEnergia(personaje){
        personaje.perderEnergia(danio)
    }
}



var nivelGuerrero  = new Nivel(nivel = 1, danio = 2)
var nivelGoblin    = new Nivel(nivel = 1, danio = 1)

//nivel 2....
//nivel 3....