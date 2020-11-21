class linkedList<T>{
  private node head;
  private int size;
  
  linkedList(){
    head = null;
    size = 0;
  }
  
  public void add(T element){
    node temp = new node(element);
    temp.setNext(head);
    head = temp;
    size++;
  }
  
  public void setSize(int _size){
    size = _size; 
  }
  
  public int getSize(){
    return size; 
  }
  
  public void setHead(node node){
    head = node; 
  }
  
  public node getHead(){
    return head; 
  }
}
