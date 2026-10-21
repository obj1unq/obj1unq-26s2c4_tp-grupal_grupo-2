import vida.*

class Imagen {
    var property image    = null
    var position = null

    method position(){
        return position
    }
    method position(position){
        position = position
    }
    method esAtravesable()

    method chocar(personaje){}

}   

class Pino inherits Imagen{

    override method esAtravesable(){
        return false 
    }
}

class Piedra inherits Imagen{

    override method esAtravesable(){
        return false 
    }


}

class Logo inherits Imagen{

    override method esAtravesable(){
        return false 
    }
}



class Inventario inherits Imagen {

    override method esAtravesable(){
        return false
    }

}





class GeneradorCraft inherits Generador{
    var aparicion   = 1
    const elementos = [espada, collar, botas, lingote] 

    override method generar(cantidadDeMuertes, personaje) {
        if (aparicion == cantidadDeMuertes && not elementos.isEmpty()) {
            aparicion += 1

            const elemento = elementos.anyOne()
            elementos.remove(elemento)
            elemento.generarEn(personaje.position())
            
        }
    }
}

var generadorCrafteo = new GeneradorCraft()

const espada = new ElementoCraft(imagenInventario = "invEspada2.png", image = "espada_lvl2.png")
const collar = new ElementoCraft(imagenInventario = "invCollar2.png", image = "collar_lvl2.png")
const botas = new ElementoCraft(imagenInventario = "invBotas2.png", image = "botas_lvl2.png")
const lingote = new ElementoCraft(imagenInventario = "invLingote2.png", image = "lingote_lvl2.png")

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