import personajes.*
import cosasEntorno.*
import mapa.*
import game.*
import musica.*

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

    var sonido 


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
        sonido.empezarMusica()
        personaje.sumarVida(energiaAplicada)
        self.remover()
        }
    }
}

class Manzana inherits Energia {
    override method energia() {
        return 1
    }

    override method remover() {
        super()
        generadorDeManzanas.eliminar(self)
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

class GeneradorManzana inherits Generador {
    const manzanas = #{}
    const capacidad

    override method generar(cantidad, personaje) {
        if (manzanas.size() < capacidad) {
            const posicion = pv.posicionRandom()
            const manzana = new Manzana(
                image = "manzana.png",
                position = posicion,
                sonido = sonidoObjeto
            )

            manzanas.add(manzana)
            game.addVisual(manzana)
        }
    }

    method eliminar(manzana) {
        manzanas.remove(manzana)
    }

    override method reiniciar() {
        manzanas.forEach({ manzana =>
            game.removeVisual(manzana)
        })
        manzanas.clear()
    }
}

class GeneradorPocion inherits Generador {
    var aparicion = 5

    const pociones = [fabricaPocionChica, fabricaPocionGrande]

    override method generar(cantidadDeMuertes, personaje){
        if(cantidadDeMuertes == aparicion){
            var fabrica = pociones.anyOne()
            fabrica.generar(personaje.position())
            aparicion += 5
        }
    }

    override method reiniciar() {
        aparicion = 5
    }
}

var generadorDeManzanas = new GeneradorManzana(capacidad = 3)
var generadorDePociones = new GeneradorPocion()

object fabricaPocionChica {

    method generar(_position) {
        var pocionChica = new PocionChica(image = "pocion_1.png", position = _position, sonido = sonidoPocion)
        game.addVisual(pocionChica)
    }
}

object fabricaPocionGrande {

    method generar(_position) {
        var pocionGrande = new PocionGrande(image = "pocion_2.png", position = _position, sonido = sonidoPocion)
        game.addVisual(pocionGrande)
    }
}

