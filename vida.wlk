import personajes.*
import cosasEntorno.*
import mapa.*
import game.*

class Corazon {
    const property position
    const indice

    method image() {
        if (guerrero.vida() >= indice) {
            return "corazon_lleno_transparente.png"
        }
        return "corazon_vacio.png"
    }

    method esAtravesable() { 
        return false 
    }
    method chocar(personaje) {

    }
}

class Energia inherits Imagen{


    override method esAtravesable(){
        return true
    }

    override method chocar(personaje){
        personaje.aumentarSalud(self)
    }

    method energia()

    method remover(){
        game.removeVisual(self)
    }

    method aumentar(personaje) {
    if (personaje.puedeAumentar()) {
        const espacioDisponible = personaje.restaDeSalud()
        const energiaAplicada = (self.energia()).min(espacioDisponible)

        personaje.sumarVida(energiaAplicada)
        self.remover()
        }
    }
}

class Manzana inherits Energia {
    override method energia(){
        return 1
    }
}

class PocionGrande inherits Energia {
    override method energia(){
        return 3
    }
}

class PocionChica inherits PocionGrande {
    override method energia(){
        return super() - 1
    }
}

class Generador {

    method generar(cantidad, personaje)

    method reiniciar(){}
}

class GeneradorManzana inherits Generador{
    var property contador = 0
    const capacidad
    
    override method generar(cantidad, personaje){
        var posicion = pv.posicionRandom()
        if (self.contador() < capacidad){
            const manzana = new Manzana(image = "manzana.png", position = posicion)
            contador += 1
            game.addVisual(manzana)
        }
    }

    override method reiniciar() {
        contador = 0
    }
}

class GeneradorPocion inherits Generador {
    var aparicion = 9

    const pociones = [fabricaPocionChica, fabricaPocionGrande]

    override method generar(cantidadDeMuertes, personaje){
        if(cantidadDeMuertes == aparicion){
            var fabrica = pociones.anyOne()
            fabrica.generar(personaje.position())
            aparicion += 9
        }
    }

    override method reiniciar() {
        aparicion = 9
    }
}

var generadorDeManzanas = new GeneradorManzana(capacidad = 3)
var generadorDePociones = new GeneradorPocion()

object fabricaPocionChica {

    method generar(_position) {
        var pocionChica = new PocionChica(image = "pocion_1.png", position = _position)
        game.addVisual(pocionChica)
    }
}

object fabricaPocionGrande {

    method generar(_position) {
        var pocionGrande = new PocionGrande(image = "pocion_2.png", position = _position)
        game.addVisual(pocionGrande)
    }
}

