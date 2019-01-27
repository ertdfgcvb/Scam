import java.util.Iterator;
import java.lang.reflect.*; 

/**
 * Returns a List of all classes that extend a certain class.
 */
ArrayList<Class> getClasses(PApplet parent, String superClassName) {
  ArrayList<Class> classes = new ArrayList<Class>();  
  Class[] c = parent.getClass().getDeclaredClasses();
  for (Class cl : c) {
    if (cl.getSuperclass() != null && (cl.getSuperclass().getSimpleName().equals(superClassName))) {
      classes.add(cl);
    }
  }
  return classes;
}

/**
 * Creates an instance of a class.
 * NOTES: 
 * - the super class must have a declared constructor
 * - the class must be public
 */
private Object createInstance(PApplet parent, Class c) {
  Object obj = null;
  
  try {   
    Constructor[] constructors = c.getConstructors();
    obj = (Object) constructors[0].newInstance(parent);    
  } 
  catch (InvocationTargetException e) {
    System.out.println(e);
  }   
  catch (InstantiationException e) {
    System.out.println(e);
  } 
  catch (IllegalAccessException e) {
    System.out.println(e);
  } 
  return obj;
}
