import direcciones.*
import estados.*

class Personaje {

  var property position
  var property personaje
  var property nivel
  var property estado = normal
  

  var posicionArriba    = new Frame(posicion = arriba)

  var posicionAbajo     = new Frame(posicion = abajo)

  var posicionDerecha   = new Frame(posicion = derecha)

  var posicionIzquierda = new Frame(posicion = izquierda)

  method posicionArriba() {
    return posicionArriba
  }

  method posicionAbajo() {
    return posicionAbajo
  }

  method posicionIzquierda() {
    return posicionIzquierda
  }

  method posicionDerecha() {
    return posicionDerecha
  }

  method position() {
    return position
  }

  method image()

  method mover(direccion)

  method atacar()

  method esAtravesable() {
    return false
  }
  
}

class Guerrero inherits Personaje {
  const enemigo = goblin
  var property posicionDeMira = posicionArriba

  override method mover(direccion) {
    if(estado.puedeMover()) {
        const nuevaPosicion = direccion.siguiente(position, self)
        const objetos = game.getObjectsIn(nuevaPosicion)
        self.validarNuevaPosicion(nuevaPosicion, objetos)
    }
  }

  method validarNuevaPosicion(nuevaPosicion, objetos) {
    if(self.sonAtravesables(objetos)) {
        position = nuevaPosicion
    }
  }

  method sonAtravesables(objetos){
    return objetos.all({ objeto => objeto.esAtravesable() })
  }

  override method atacar() {
      if(estado.puedeAtacar()) {
        estado = ataque
        posicionDeMira.iniciarFrames()
        self.validarEnemigo()
     }
  }

  method validarEnemigo(){
    const casilleroAtaque = posicionDeMira.casilleroSiguiente(position)
    if(enemigo.position() == casilleroAtaque) {
          enemigo.recibirDanio()
    }
  }

  

  override method image() {
    return posicionDeMira.image(personaje, nivel, estado)
  }

  method redibujar() {
    game.removeVisual(self)
    game.addVisual(self)
  }

}



class Goblin inherits Personaje {

  var property posicionDeMira = posicionAbajo

  override method mover(direccion) {}
  override method atacar() {}

  override method image() {
    return posicionDeMira.image(personaje, nivel, estado)
  }

  method recibirDanio(){
    estado = danio
    posicionDeMira.iniciarFrames()
  }

}

var goblin   = new Goblin(position = game.at(3,3), personaje = "goblin", nivel = 1)
var guerrero = new Guerrero(position = game.origin(),  personaje = "guerrero", nivel = 1)