import game.*
import personajes.*
import cosasEntorno.*
import nivelPersonajes.*


class Estado {
    const nombre
    const puedeMover
    const puedeAtacar
    const maxFramesEstado
    var frameActual = 1

    method nombre() {
        return nombre
    }

    method puedeMover() {
        return puedeMover
    }

    method puedeAtacar() {
        return puedeAtacar
    }

    method image(personaje, nivel, direccion) {
        return direccion + "_" + personaje + nivel.nivel() + self.nombre() + "_" + frameActual + ".png"
    }

    method avanzarFrame(personaje) {
    if (self.terminoAnimacion()) {
        self.finalizarAnimacion(personaje)
    }
    else {
        frameActual += 1
        }
    }

    method reiniciarAnimacion() {
        frameActual = 1
    }

    method terminoAnimacion() {
        return frameActual == maxFramesEstado
    }

    method finalizarAnimacion(personaje) {
        personaje.cambiarEstado(personaje.normal())
    }

    method ejecutar(personaje, nivel){}

}


class Normal inherits Estado {

    override method avanzarFrame(personaje) {
        if (self.terminoAnimacion()) {
            self.reiniciarAnimacion()
        }
        else {
            frameActual += 1
        }
    }

    override method finalizarAnimacion(personaje) {}

    

}




class Ataque inherits Estado {

    override method ejecutar(personaje, nivel){
        personaje.ejecutarAtaque()
    }
}


class Danio inherits Estado {

    override method ejecutar(personaje, nivel){
        
    }
}


class MuerteGoblin inherits Estado {
    override method finalizarAnimacion(personaje) {
        game.removeVisual(personaje)
        generadorGoblins.eliminar(personaje)
    }
    override method ejecutar(personaje, nivel){}
}


class MuerteGuerrero inherits Estado {
    override method finalizarAnimacion(personaje) {}

    override method ejecutar(personaje, nivel){

    }
}


class Transformacion inherits Estado {
    override method image(personaje, nivel, direccion) {
        return personaje + "_" + self.nombre() + "_" + frameActual + ".png"
    }

    override method ejecutar(personaje, nivel){
        self.subirNivel(personaje, nivel)
        personaje.craftear()
        inventarios.desocuparTodos()
    }

    method subirNivel(personaje, nivelActual){
        var nuevoNivel = new Nivel(nivel = nivelActual.nivel() + 1, danio = nivelActual.danio() + 1)
        personaje.subirNivel(nuevoNivel)
    }
}





class EstadoPersonaje {
    const normal = new Normal(nombre = "normal", puedeMover = true, puedeAtacar = true, maxFramesEstado = 6)
    const ataque = new Ataque(nombre = "ataque", puedeMover = false, puedeAtacar = false, maxFramesEstado = 8)
    const danio  = new Danio(nombre = "danio", puedeMover = false, puedeAtacar = false, maxFramesEstado = 6)
    
    
    method normal(){
        return normal
    }

    method ataque(){
        return ataque
    }

    method danio(){
        return danio
    }

    method muerte()

    method transformacion()

}


class EstadoGoblin inherits EstadoPersonaje {
    const muerteGoblin = new MuerteGoblin(nombre = "muerte", puedeMover = false, puedeAtacar = false, maxFramesEstado = 8)
    
    override method muerte() {
        return muerteGoblin
    }
    
    override method transformacion(){}
}

class EstadoGuerrero inherits EstadoPersonaje {
    const transformacion = new Transformacion(nombre = "transformacion", puedeMover = false, puedeAtacar = false, maxFramesEstado = 2)
    const muerteGuerrero = new MuerteGuerrero(nombre = "muerte", puedeMover = false, puedeAtacar = false, maxFramesEstado = 8)

    override method transformacion() {
        return transformacion
    }

    override method muerte() {
        return muerteGuerrero
    }
}