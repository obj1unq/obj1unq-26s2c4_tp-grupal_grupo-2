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

  method chocar(entidad){
  
  }
  
}


class Guerrero inherits Personaje {
  
  var property posicionDeMira = posicionArriba
  var vida                    = 6
  var maxSaludDeNivel         = 6

  method vida(){
    return vida
  }

  method vida(danio){
    vida -= danio
  }

  method sumarVida(_vida){
    vida += _vida
  }
  
  override method atacar() {
      if(estado.puedeAtacar()) {
        estado = ataque
        posicionDeMira.reiniciar()
        self.validarEnemigo()
     }
  }


  method validarEnemigo() {
    const casilleroAtaque = posicionDeMira.casilleroSiguiente(position)
    generadorGoblins.goblins().forEach({ enemigo => self.fijarEnemigo(enemigo, casilleroAtaque) })
  }

  method fijarEnemigo(enemigo, casillero){
    if (enemigo.position() == casillero) {
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
    if(self.puedeAumentarSalud()){
      self.aumentar(suministroDeSalud)
    }
  }

  method aumentar(suministroDeSalud){
    if(self.sumaDeSalud(suministroDeSalud) <= maxSaludDeNivel){
      self.sumarVida(suministroDeSalud.energia())
      suministroDeSalud.remover()
      
    }
    else {
      self.sumarVida(self.restaDeSalud())
      suministroDeSalud.remover()
    }
  }

  method puedeAumentarSalud(){
    return self.vida() < maxSaludDeNivel
  }

  method restaDeSalud(){
    return maxSaludDeNivel - self.vida()
  }

  method sumaDeSalud(suministroDeSalud){
    return self.vida() + suministroDeSalud.energia()
  }

  method redibujar() {
    game.removeVisual(self)
    game.addVisual(self)
  }

}



class Goblin inherits Personaje {
  const enemigo = guerrero
  var property posicionDeMira 
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

  
  method perseguirGuerrero() {
    self.perseguirDerecha()
    self.perseguirIzquierda()
    self.perseguirArriba()
    self.perseguirAbajo()
  }

  method perseguirDerecha(){
    if (position.x() < guerrero.position().x()) {
      self.mover(derecha)
    }
  }
  method perseguirIzquierda(){
    if (position.x() > guerrero.position().x()) {
      self.mover(izquierda)
    }
  }
  method perseguirArriba(){
    if (position.y() < guerrero.position().y()) {
      self.mover(arriba)
    }
  }
  method perseguirAbajo(){
    if (position.y() > guerrero.position().y()) {
      self.mover(abajo)
    }
  }

}


class GeneradorGoblins inherits Generador{
  var property goblins = #{}
  const posicionesPosibles = #{nivel.posicionesPosiblesAbajo(), nivel.posicionesPosiblesArriba(), nivel.posicionesPosiblesDerecha(), nivel.posicionesPosiblesIzquierda()}

  var posicionArriba    = new Frame(posicion = arriba)
  var posicionAbajo     = new Frame(posicion = abajo)
  var posicionDerecha   = new Frame(posicion = derecha)
  var posicionIzquierda = new Frame(posicion = izquierda)

  const posicionesDeMira = #{posicionArriba, posicionAbajo, posicionDerecha, posicionIzquierda}

  override method generar(){
    var posiciones = posicionesPosibles.anyOne()
    const nuevoGoblin = new Goblin(position = posiciones.anyOne(), personaje = "goblin", nivel = nivelGoblin1, posicionDeMira = posicionesDeMira.anyOne())
    goblins.add(nuevoGoblin)
    game.addVisual(nuevoGoblin)
  }

  method eliminar(goblin) {
    goblins.remove(goblin)
  }
}

var generadorGoblins = new GeneradorGoblins(capacidad = 20)


var guerrero = new Guerrero(position = game.origin(), personaje = "guerrero", nivel = nivelGuerrero1)