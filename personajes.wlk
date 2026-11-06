import direcciones.*
import estados.*
import nivelPersonajes.*
import cosasEntorno.*
import vida.*
import mapa.*


class Personaje {

  var property position
  var property personaje
  var property nivel
  var property esAtravesable   = false
  var property estado 
  const estados
  var property direccionActual = abajo
  var vida                     = 6

  method vida() {
      return vida
  }

  method position() {
    return position
  }

  method normal(){
    return estados.normal()
  }

  method ataque(){
    return estados.ataque()
  }

  method danio(){
    return estados.danio()
  }

  method transformacion(){
    return estados.transformacion()
  }

  method muerte(){
    return estados.muerte()
  }


  method image() {
    return estado.image(personaje, nivel, direccionActual.nombre())
  }

  method chocar(entidad){}

  method cambiarEstado(_estado){
    estado = _estado
    estado.reiniciarAnimacion()
  }

  method estaMuerto(){
    return vida == 0
  }

  method validarMuerte(){
    self.muerte().muerte(self)
}

  method puedePerderEnergia(){
    return vida > 0
  }

  

  

  method vida(danio){
    vida -= danio
  }

  method perderEnergia(danio){
    self.vida(danio)
    self.validarMuerte()
  }

  method ejecutarAtaque(){}

  method cambiarDireccion(direccion){
    direccionActual = direccion
  }

  method atacar() {
    self.ataque().atacar(self)
  }

  method mover(direccion) {
    estado.mover(direccion, self)
  }

  method recibirDanio() {
    self.danio().recibirDanio(self)
  }


}


class Guerrero inherits Personaje {
  const elementosCrafts          = #{}
  var property maxSaludDeNivel   = 6


  method elementosCrafts(){
    return elementosCrafts
  }

  method agregarElementoCraft(elemento){
    elementosCrafts.add(elemento)
  }

  method sumarVida(_vida){
    vida += _vida
  }
  
  method fijarEnemigo(enemigo, casillero) {
    if (enemigo.position() == casillero) {
        enemigo.recibirDanio()
        nivel.perderEnergia(enemigo)
    }
}

  method validarEnemigo() {
    const casilleroAtaque = direccionActual.siguiente(position)
    generadorGoblins.goblins().forEach({ enemigo => self.fijarEnemigo(enemigo, casilleroAtaque) })
  }

  override method ejecutarAtaque() {
    self.validarEnemigo()
  }


  //Interactua con objetos en la misma posicion que el personaje guerrero
  method interactuar() {
    const objetos = game.getObjectsIn(position)
    const objetosAtravesables = objetos.filter({ objeto => objeto.esAtravesable() })

    self.interactuarConItems(objetosAtravesables)
  }

  method interactuarConItems(objetos){
    if (!objetos.isEmpty()) {
        objetos.first().chocar(self)
    }
  }

  method aumentarSalud(suministroDeSalud){
      suministroDeSalud.aumentar(self)
  }

  method puedeAumentar(){
    return self.vida() < self.maxSaludDeNivel()
}

  method restaDeSalud(){
    return maxSaludDeNivel - vida
  }


  method transformar() {
    self.transformacion().transformar(self, nivel)
  }

  method craftear(){
    elementosCrafts.clear()
  }

  method sePuedeTransformar(){
    return elementosCrafts.size() == 4
  }

  method subirNivel(nuevoNivel){
    nivel = nuevoNivel
    maxSaludDeNivel += 2
    vida = maxSaludDeNivel
    c.agregarCorazon()
    c.agregarCorazon()
  }

  method redibujar() {
    game.removeVisual(self)
    game.addVisual(self)
  }
}

class Goblin inherits Personaje {
  const enemigo = guerrero

  override method mover(direccion) {
      super(direccion)
      self.atacarGuerrero()
  }

  method atacarGuerrero() {
    const casilleroAtaque = direccionActual.siguiente(position)

    if (enemigo.position() == casilleroAtaque) {
        self.atacar()
    }
  }

  override method ejecutarAtaque() {
    enemigo.recibirDanio()
    nivel.perderEnergia(enemigo)
  }

  method perseguirGuerrero() {
      self.perseguirDerecha()
      self.perseguirIzquierda()
      self.perseguirArriba()
      self.perseguirAbajo()
  }

  method perseguirDerecha() {
      if (position.x() < guerrero.position().x()) {
          self.mover(derecha)
      }
  }

  method perseguirIzquierda() {
      if (position.x() > guerrero.position().x()) {
          self.mover(izquierda)
      }
  }

  method perseguirArriba() {
      if (position.y() < guerrero.position().y()) {
          self.mover(arriba)
      }
  }

  method perseguirAbajo() {
      if (position.y() > guerrero.position().y()) {
          self.mover(abajo)
      }
  }

}


class GeneradorGoblins inherits Generador {
  var property goblins = #{}
  var property cantidadMuertes = 0
  var property capacidad
  const posicionesPosibles = #{
      nivel.posicionesPosiblesAbajo(),
      nivel.posicionesPosiblesArriba(),
      nivel.posicionesPosiblesDerecha(),
      nivel.posicionesPosiblesIzquierda()
  }
  override method generar(cantidad, personaje) {
      if (cantidadMuertes < capacidad) {
          var posiciones = posicionesPosibles.anyOne()
          const estadosGoblin = new EstadoGoblin()
          
          const nuevoGoblin = new Goblin(estados = estadosGoblin, estado = estadosGoblin.normal(), position = posiciones.anyOne(), personaje = "goblin", nivel = nivelGoblin)
          goblins.add(nuevoGoblin)
          game.addVisual(nuevoGoblin)
      }
  }
  method eliminar(goblin) {
      cantidadMuertes += 1
      generadorDePociones.generar(cantidadMuertes, goblin)
      generadorCrafteo.generar(cantidadMuertes, goblin)
      goblins.remove(goblin)
  }
}

var generadorGoblins = new GeneradorGoblins(capacidad = 20)

var estadosGuerrero = new EstadoGuerrero()

var guerrero = new Guerrero(estados = estadosGuerrero, estado = estadosGuerrero.normal(), position = game.origin(), personaje = "guerrero", nivel = nivelGuerrero)