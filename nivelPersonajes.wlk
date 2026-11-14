

class Nivel {

    var property nivel
    var property danio

    method perderEnergia(personaje){
        personaje.perderEnergia(danio)
    }
}



var nivelGuerrero  = new Nivel(nivel = 1, danio = 2)
var nivelGoblin    = new Nivel(nivel = 1, danio = 1)
var nivelGoblinCueva = new Nivel(nivel = 2, danio = 2)