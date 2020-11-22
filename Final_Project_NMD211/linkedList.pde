class linkedList<T>{
  private node<T> head;
  private int size;
  
  linkedList(){
    head = null;
    size = 0;
  }
  
  public void add(T element){
    node<T> temp = new node<T>(element);
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
