class node<T>{
  private T element;
  private node<T> nextNode;
  
  node(){
    element = null;
    nextNode = null;
  }
  
  node(T _element){
    element = _element;
    nextNode = null;
  }
  
  public void setElement(T _element){
    element = _element;
  }
  
  public T getElement(){
    return element;
  }
  
  public void setNext(node<T> next){
    nextNode = next; 
  }
  
  public node getNext(){
    return nextNode; 
  }
  
  public String toString(){
    return element+" "+nextNode; 
  }
}
