import vida.*
import administradorNiveles.*

class Imagen {
    var property image    = null
    var position = null

    method position(){
        return position
    }
    method position(_position){
        position = _position
    }
    method esAtravesable() {
        return false
    }

    method chocar(personaje){}

}   

class Pino inherits Imagen {

    override method esAtravesable(){
        return false 
    }
}

class Piedra inherits Imagen {}

class Logo inherits Imagen {}

class Fogata inherits Imagen {}

class Choza inherits Imagen {}



class Inventario inherits Imagen {}


class GeneradorCraft inherits Generador {
    var aparicion = 1

    override method generar(cantidadDeMuertes, personaje) {
        const elementos = administradorNiveles.nivelActual().elementosDeTransformacion()

        if (aparicion == cantidadDeMuertes && aparicion <= elementos.size()) {
            elementos.get(aparicion - 1).generarEn(personaje.position())
            aparicion += 1
        }
    }

    override method reiniciar() {
        aparicion = 1
    }
}

var generadorCrafteo = new GeneradorCraft()

const espada2 = new ElementoCraft(imagenInventario = "invEspada2.png", image = "espada_lvl2.png")
const collar2 = new ElementoCraft(imagenInventario = "invCollar2.png", image = "collar_lvl2.png")
const botas2 = new ElementoCraft(imagenInventario = "invBotas2.png", image = "botas_lvl2.png")
const lingote2 = new ElementoCraft(imagenInventario = "invLingote2.png", image = "lingote_lvl2.png")

const espada3 = new ElementoCraft(imagenInventario = "invEspada3.png", image = "espada_lvl3.png")
const armadura3 = new ElementoCraft(imagenInventario = "invArmadura3.png", image = "armadura_lvl3.png")
const botas3 = new ElementoCraft(imagenInventario = "invBotas3.png", image = "botas_lvl3.png")
const lingote3 = new ElementoCraft(imagenInventario = "invLingote3.png", image = "lingote_lvl3.png")

class ElementoCraft inherits Imagen{
    var property imagenInventario

    override method esAtravesable(){
        return true
    }

    override method chocar(personaje){
        inventarios.agregarElementoCraft(self, personaje)
        game.removeVisual(self)
    }

    method generarEn(posicion){
        var elementoCraf = new ElementoCraft(imagenInventario = self.imagenInventario(), image = self.image(), position = posicion)
        game.addVisual(elementoCraf)
    }
    
}


class CasilleroInventario {
    var estaOcupado       = false
    var posicion          = null

    method poner(position){
        game.addVisual(new Inventario(image = "inv.png", position = position))
        posicion = position
    }

    method estaOcupado(){
        return estaOcupado
    }

    method ocupado(elemento){
        game.addVisual(new Inventario(image = elemento.imagenInventario(), position = posicion))
        estaOcupado = true
    }

    method desocupar(){
        game.removeVisual(self)
        self.poner(posicion)
        estaOcupado = false
    }

    method crearVisual(position) {
        posicion = position
        return new Inventario(image = "inv.png", position = position)
    }
}

var i1 = new CasilleroInventario()
var i2 = new CasilleroInventario()
var i3 = new CasilleroInventario()
var i4 = new CasilleroInventario()

object inventarios {
    const casilleros = #{i1, i2, i3, i4}

    method agregarElementoCraft(elemento, personaje){
        if(self.hayEspacio()){
            const inventarioLibre = casilleros.find({ casillero => not casillero.estaOcupado() })
            inventarioLibre.ocupado(elemento)
            game.removeVisual(inventarioLibre)
            personaje.agregarElementoCraft(elemento)
        }
    }

    method hayEspacio(){
        return casilleros.any({ casillero => not casillero.estaOcupado() })
    }

    method desocuparTodos(){
        casilleros.forEach({ casillero => casillero.desocupar() })
    }
}