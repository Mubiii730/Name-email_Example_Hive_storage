import 'package:flutter/material.dart'; 
import 'package:hive_practice/Hive_functions.dart'; 
  
class MainScreen extends StatefulWidget { 
  const MainScreen({super.key}); 
  
  @override 
  State<MainScreen> createState() => _MainScreenState(); 
} 
  
class _MainScreenState extends State<MainScreen> { 
  List myHiveData = []; 
    
  final TextEditingController _nameController = TextEditingController(); 
  final TextEditingController _emailController = TextEditingController(); 
    
 
  getHiveData() { 
    myHiveData = HiveFunctions.getAllUsers(); 
    setState(() {}); 
  } 
  deleteAllUser(){
    HiveFunctions.deleteAllUser(myHiveData.length);
    getHiveData();
    
  }
  
  @override 
  void initState() { 
    super.initState(); 
    getHiveData(); 
  } 
  
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
        appBar: AppBar( 
          title: const Text("CRUD Operations"), 
          actions: [ 
           
            IconButton( 
                onPressed: getHiveData,
                icon: const Icon(Icons.refresh)),
                IconButton(onPressed: (){
                  
                  HiveFunctions.deleteAllUser(myHiveData.length);
                  getHiveData();
                  
                }, icon:const Icon(Icons.delete)) 
          ], 
        ), 
        
        floatingActionButton: FloatingActionButton.extended( 
            label: const Text("Add Data"), 
            icon: const Icon(Icons.add), 
            onPressed: () { 
              showForm(null); 
            }), 
        body: Padding( 
          padding: const EdgeInsets.all(8.0), 
          child: myHiveData.isEmpty 
              ? const Center( 
                  child: Text( 
                  "No Data is Stored", 
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600), 
                )) 
              
              : Column( 
                  children: List.generate(myHiveData.length, (index) { 
                  final userData = myHiveData[index]; 
                  return Card( 
                    child: ListTile( 
                      title: 
                          Text("Name : ${userData["name"]}"), 
                      subtitle: 
                          Text("Email : ${userData["email"]}"), 
                      trailing: Row( 
                        mainAxisSize: MainAxisSize.min, 
                        children: [ 
                        
                          IconButton( 
                              onPressed: () { 
                                showForm(userData["key"]); 
                              }, 
                              icon: const Icon(Icons.edit)), 
                        
                          IconButton( 
                              onPressed: () { 
                                HiveFunctions.deleteUser(userData["key"]); 
                              
                                getHiveData(); 
                              }, 
                              icon: const Icon(Icons.delete)), 
                        ], 
                      ), 
                    ), 
                  ); 
                }).toList()), 
        )); 
  } 
  

void showForm(int? itemKey) async { 
  
    if (itemKey != null) { 
     
      final existingItem = 
          myHiveData.firstWhere((element) => element['key'] == itemKey); 
      _nameController.text = existingItem['name']; 
      _emailController.text = existingItem['email']; 
    } 
  
    showModalBottomSheet( 
        context: context, 
        elevation: 5, 
        isScrollControlled: true, 
        builder: (_) => Container( 
              padding: EdgeInsets.only( 
                  bottom: MediaQuery.of(context).viewInsets.bottom, 
                  top: 15, 
                  left: 15, 
                  right: 15), 
              child: Column( 
                mainAxisSize: MainAxisSize.min, 
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [ 
                  Center( 
                      child: Text( 
                    itemKey == null ? 'Create New' : 'Update', 
                    style: const TextStyle( 
                        fontSize: 22, fontWeight: FontWeight.w600), 
                  )), 
                  TextField( 
                    controller: _nameController, 
                    decoration: const InputDecoration(hintText: 'Name'), 
                  ), 
                  const SizedBox( 
                    height: 10, 
                  ), 
                  TextField( 
                    controller: _emailController, 
                    keyboardType: TextInputType.number, 
                    decoration: const InputDecoration(hintText: 'Email'), 
                  ), 
                  const SizedBox( 
                    height: 20, 
                  ), 
                  ElevatedButton( 
                    onPressed: () async { 
                   
                      if (itemKey == null) { 
                        HiveFunctions.createUser({ 
                          "email": _emailController.text, 
                          "name": _nameController.text 
                        }); 
                      } 
  
                   
                      if (itemKey != null) { 
                        HiveFunctions.updateUser(itemKey, { 
                          "email": _emailController.text, 
                          "name": _nameController.text 
                        }); 
                      } 
  
                     
                      _nameController.text = ''; 
                      _emailController.text = ''; 
  
                      Navigator.of(context).pop(); // Close the bottom sheet 
                      
                      getHiveData(); 
                    }, 
                    child: Text(itemKey == null ? 'Create New' : 'Update'), 
                  ), 
                  const SizedBox( 
                    height: 15, 
                  ) 
                ], 
              ), 
            )); 
  } 
}