//
//  CoreDataRelationshipBootcamp.swift
//  ContinuedLearning
//
//  Created by karma on 6/3/22.
//

import SwiftUI
import CoreData
// business entity
// employee entity
// department entity


class CoreDataManager {
    
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription,"erorr loading data")
            }
        }
        context = container.viewContext
    }
    
    func saveData() {
        do {
            try context.save()
            print("save successful")
        } catch let error {
            print(error.localizedDescription,"error saving data")
        }
    }
    
}

class CoreDataRelationshipViewModel: ObservableObject {
    
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity]  = []
    @Published var employees: [EmployeeEntity] = []
    
    init() {
        getBusinesses()
        getDepartments()
        
    }
    let manager = CoreDataManager.instance
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Business"
        
        // add existing departments to the new business
         newBusiness.departments = [departments[0],departments[1]]
        
        // add existing employees to the new business
         newBusiness.employees = [employees[2]]
        
        // add new business to existing department
        // newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        
        // add new businness to existing employees
        // newBusiness.addToEmployees(<#T##values: NSSet##NSSet#>)
        
        save()
    }
    
    func addDepartments() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Engineering"
//        newDepartment.businesses = [businesses[0]]
        newDepartment.addToEmployees(employees[2])
        save()
    }
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.name = "Emily"
        newEmployee.age = 20
        newEmployee.dateJoined = Date()
        
        newEmployee.business = businesses.first
        newEmployee.department = departments[0 ]
        save()
    }
    
    func getBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        do{
            businesses = try manager.context.fetch(request)
        } catch let error {
            print(error.localizedDescription,"error fetching data")
        }
        
    }
    
    func getDepartments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        do{
            departments = try manager.context.fetch(request)
        } catch let error {
            print(error.localizedDescription,"error fetching data")
        }
        
    }
    
    func getEmployees() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        do{
            employees = try manager.context.fetch(request)
        } catch let error {
            print(error.localizedDescription,"error fetching data")
        }
        
    }
    
    func save() {
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.manager.saveData()
            self.getBusinesses()
            self.getDepartments()
            self.getEmployees()
        }
    }
    
    
}

struct CoreDataRelationshipBootcamp: View {
    @StateObject var vm = CoreDataRelationshipViewModel()
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 20) {
                    Button {
                        vm.addBusiness()
                    } label: {
                        Text("Perform action")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                         
                            .background(.blue)
                            .cornerRadius(10)
                        
                    }
                    ScrollView(.horizontal, showsIndicators: true, content: {
                        HStack(alignment: .top) {
                            ForEach(vm.businesses) { business in
                                BusinessView(entity: business)
                            }
                        }
                    })
                    ScrollView(.horizontal, showsIndicators: true, content: {
                        HStack(alignment: .top) {
                            ForEach(vm.departments) { department in
                                DepartmentView(entity: department)
                            }
                        }
                    })
                    ScrollView(.horizontal, showsIndicators: true, content: {
                        HStack(alignment: .top) {
                            ForEach(vm.employees) { employee in
                                EmployeeView(entity: employee)
                            }
                        }
                    })
                }
                .padding()
            }
            .navigationTitle("Relationships")
        }
    }
}

struct CoreDataRelationshipBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationshipBootcamp()
    }
}

struct BusinessView: View {
    let entity: BusinessEntity
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            Text(entity.name ?? "")
                .bold()
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments")
                    .bold()
                ForEach(departments) {deparment in
                    Text(deparment.name ?? "")
                }
            }
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees")
                    .bold()
                ForEach(employees) {employee in
                    Text(employee.name ?? "")
                }
                    
            }
        }
        .padding()
        .frame(maxWidth: 300,alignment: .leading)
        .background(.thinMaterial)
        .cornerRadius(10)
    }
}

struct DepartmentView: View {
    let entity: DepartmentEntity
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            Text(entity.name ?? "")
                .bold()
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
                Text("Businesses")
                    .bold()
                ForEach(businesses) {business in
                    Text(business.name ?? "")
                }
            }
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees")
                    .bold()
                ForEach(employees) {employee in
                    Text(employee.name ?? "")
                }
                    
            }
        }
        .padding()
        .frame(maxWidth: 300,alignment: .leading)
        .background(.green.opacity(0.5))
        .background(.thinMaterial)
        
        .cornerRadius(10)
    }
}

struct EmployeeView: View {
    let entity: EmployeeEntity
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            Text(entity.name ?? "")
                .bold()
            Text("Age: \(entity.age)")
            Text("Date joined: \(entity.dateJoined ?? Date())")
            
            Text("Business")
                .bold()
            Text(entity.business?.name ?? "")
            Text("Department")
                .bold()
            Text(entity.department?.name ?? "")
        }
        .padding()
        .frame(maxWidth: 300,alignment: .leading)
        .background(.blue.opacity(0.5))
        .background(.thinMaterial)
        
        .cornerRadius(10)
    }
}

