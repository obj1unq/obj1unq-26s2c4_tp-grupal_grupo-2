import direcciones.*
import estados.*
import nivelPersonajes.*


class Personaje {

  var property position
  var property personaje
  var property nivel
  var property esAtravesable = false
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

  method posicionDerecha() {
    return posicionDerecha
  }

  method posicionIzquierda() {
    return posicionIzquierda
  }

  method position() {
    return position
  }

  method image()

  method mover(direccion) 

  method atacar()
  
}


class Guerrero inherits Personaje {
  const enemigo = goblin
  var property posicionDeMira = posicionArriba
  var vida = 9

  method vida(){
    return vida
  }

  method vida(danio){
    vida -= danio
  }
  
  override method atacar() {
      if(estado.puedeAtacar()) {
        estado = ataque
        posicionDeMira.reiniciar()
        self.validarEnemigo()
     }
  }


  method validarEnemigo(){
    const casilleroAtaque = posicionDeMira.casilleroSiguiente(position)
    if(enemigo.position() == casilleroAtaque) {
          enemigo.recibirDanio()
          nivel.perderEnergia(enemigo)
    }
  }

  override method image() {
    return posicionDeMira.image(personaje, nivel, estado)
  }


  override method mover(direccion) {
    if(estado.puedeMover()) {
        const nuevaPosicion = direccion.siguiente(position, self)
        const objetos = game.getObjectsIn(nuevaPosicion)
        direccion.validarNuevaPosicion(self, nuevaPosicion, objetos)
    }
  }

  
  method recibirDanio() {
      if (vida > 0) {
          estado = danio
          posicionDeMira.reiniciar()
      }
  }


  method perderEnergia(danio){
    self.vida(danio)
    self.validarMuerte()
  }

  method validarMuerte(){
    if(vida == 0){
      estado = muerteGuerrero
      posicionDeMira.reiniciar()
    }
  }


  method redibujar() {
    game.removeVisual(self)
    game.addVisual(self)
  }

}



class Goblin inherits Personaje {
  const enemigo = guerrero
  var property posicionDeMira = posicionAbajo
  var vida = 6

  method vida(){
    return vida
  }

  method vida(danio){
    vida -= danio
  }

  override method atacar() {
      if(estado.puedeAtacar()) {
        estado = ataque
        posicionDeMira.reiniciar()

    }
  }
  override method mover(direccion) {
    if(estado.puedeMover()) {
      const nuevaPosicion = direccion.siguiente(position, self)
      const objetos = game.getObjectsIn(nuevaPosicion)
      self.validarEnemigo()
      direccion.validarNuevaPosicion(self, nuevaPosicion, objetos)
    }
  }

  method validarEnemigo(){
    const casilleroAtaque = posicionDeMira.casilleroSiguiente(position)
    if(enemigo.position() == casilleroAtaque) {
      self.atacar()
      enemigo.recibirDanio()
      nivel.perderEnergia(enemigo)
    }
  }

  override method image() {
    return posicionDeMira.image(personaje, nivel, estado)
  }

  method recibirDanio(){
    estado = danio
    posicionDeMira.reiniciar()
  }

  method perderEnergia(danio){
    self.vida(danio)
    self.validarMuerte()
  }

  method validarMuerte(){
    if(vida == 0){
      estado = muerteGoblin
      posicionDeMira.reiniciar()
    }
  }
}



var goblin = new Goblin(position = game.at(3,3), personaje = "goblin", nivel = nivelGoblin1)

var guerrero = new Guerrero(position = game.origin(), personaje = "guerrero", nivel = nivelGuerrero1)