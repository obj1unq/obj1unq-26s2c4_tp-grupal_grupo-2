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

class Manzana inherits Imagen{


    override method esAtravesable(){
        return true
    }

    override method chocar(personaje){
        personaje.aumentarSalud(self)
    }

    method energia(){
        return 1
    }

    method remover(){
        game.removeVisual(self)
    }
}

class Generador {
    var property contador = 0
    const capacidad

    method generar()
}

class GeneradorManzanas inherits Generador{
    const posicionesPosibles = #{nivel.posicionesPosiblesAbajo(), nivel.posicionesPosiblesArriba(), nivel.posicionesPosiblesDerecha(), nivel.posicionesPosiblesIzquierda()}
    override method generar(){
        var posiciones = posicionesPosibles.anyOne()
        if (self.contador() < capacidad){
            var positionRandom = posiciones.anyOne()
            const manzana = new Manzana(image = "manzana.png", position = positionRandom)
            contador += 1
            game.addVisual(manzana)
        }
    }
}

var generadorDeManzanas = new GeneradorManzanas(capacidad = 3)