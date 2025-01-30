class Value

  @from: ( value ) ->
    self = new Value
    self.value = value
    self
  
  @promise: ->
    self = new Value
    self.promise = new Promise ( resolve ) ->
      self.resolve = resolve
    self
  
  get: -> @promise ? @value

  set: ( @value ) ->
    if @promise?
      @resolve @value
      { @resolve, @promise } = {}
    @value

export default Value