import direcciones.*

object guerrero {
  var property energy = 100
  var property position = game.origin()
  var property posicionDeMira = abajo1

  method energy(){
    return energy
  }

  method position(){
    return position
  }

  method image() {
    return posicionDeMira.image()
  }

  method mover(direccion) {
    position = direccion.siguiente(position, self)
  }

  method atacar(){
    return posicionDeMira.atacar()
  }
}

