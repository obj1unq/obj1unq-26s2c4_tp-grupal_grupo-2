import direcciones.*

class Personaje {

  var property position 
  var property posicionDeMira
  var property personaje
  var property nivel
  var arriba    = new MiraADireccion(maxFramesMov = 6, direccion = "arriba_", maxFramesAtaq = 8)
  var abajo     = new MiraADireccion(maxFramesMov = 6, direccion = "abajo_", maxFramesAtaq = 8)
  var derecha   = new MiraADireccion(maxFramesMov = 6, direccion = "derecha_", maxFramesAtaq = 8)
  var izquierda = new MiraADireccion(maxFramesMov = 6, direccion = "izquierda_", maxFramesAtaq = 8)

  method arriba() {
  return arriba
}

method abajo() {
  return abajo
}

method izquierda() {
  return izquierda
}

method derecha() {
  return derecha
}

  method position(){
    return position
  }

  method image(){
    return posicionDeMira.image(personaje, nivel)
  }

  method mover(direccion) 

  method atacar()
}

class Guerrero inherits Personaje {
  
  override method mover(direccion) {
    if(not posicionDeMira.ataque())
      position = direccion.siguiente(position, self)
  }

  override method atacar(){
    return posicionDeMira.atacar()
  }
}

class Goblin inherits Personaje {

  override method mover(direccion) {}
  override method atacar() {}
}

var posicionInicio = new MiraADireccion(maxFramesMov = 6, direccion = "derecha_", maxFramesAtaq = 8)
var guerrero = new Guerrero(position = game.origin(), posicionDeMira = posicionInicio, personaje = "guerrero", nivel = 1)
var goblin   = new Goblin(position = game.at(3,3), posicionDeMira = posicionInicio, personaje = "goblin", nivel = 1)