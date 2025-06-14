import SwiftUI
struct TabBarItem{
    let name: String
    let image: String
}

struct Dish: Identifiable{
    let id = UUID()
    let image: String
    let name: String
    let time: String
}

struct NewRecipe: Identifiable{
    let id = UUID()
    let image: String
    let recipeName: String
    let time: String
    let rating: Int
    let chefName: String
    let chefImage: String
}

struct HomeView: View {
    @ObservedObject var viewModel: ProfileViewViewModel
    @State private var selectedTab = 0
    let tabbaritems: [TabBarItem] = [
        TabBarItem(name: "Home", image: "house.circle.fill"),
        TabBarItem(name: "Saved", image: "bookmark.fill"),
        TabBarItem(name: "Notifications", image: "bell.fill"),
        TabBarItem(name: "Profile", image: "person.circle.fill")
    ]
    @State private var selectedCategory: String = "All"
    let categories = ["All", "Indian", "Italian", "Chinese", "Fruits", "Vegetables", "Protein"]

    let dishes: [String: [Dish]] = [
        "All": [
            Dish(image: "butter_chicken", name: "Butter Chicken", time: "40 mins"),
            Dish(image: "fried_rice", name: "Fried Rice", time: "20 mins"),
            Dish(image: "chowmin", name: "Chowmin", time: "25 mins"),
            Dish(image: "daal", name: "Dal", time: "30 mins"),
            Dish(image: "naan", name: "Naan", time: "15 mins"),
            Dish(image: "smosa", name: "Samosa", time: "40 mins"),
            Dish(image: "momos", name: "Momos", time: "30 mins")
            // Add more dishes here
        ],
        "Indian": [
            Dish(image: "panner_tikka", name: "Paneer Tikka", time: "25 mins"),
            Dish(image: "butter_naan", name: "Butter Naan", time: "15 mins"),
            Dish(image: "chicken_curry", name: "Chicken Curry", time: "35 mins"),
            Dish(image: "chhole_bhature", name: "Chole Bhature", time: "40 mins"),
            Dish(image: "smosa", name: "Samosa", time: "20 mins")
        ],
        "Italian": [
            Dish(image: "pizza", name: "Pizza", time: "30 mins"),
            Dish(image: "pasta", name: "Pasta", time: "25 mins"),
            Dish(image: "lasagna", name: "Lasagna", time: "45 mins"),
            Dish(image: "risotto", name: "Risotto", time: "35 mins"),
            Dish(image: "tiramisu", name: "Tiramisu", time: "15 mins")
        ],
        "Chinese": [
            Dish(image: "fried_rice", name: "Fried Rice", time: "20 mins"),
            Dish(image: "spring_rolls", name: "Spring Rolls", time: "25 mins"),
            Dish(image: "manchurian", name: "Manchurian", time: "30 mins"),
            Dish(image: "kung_pao_chicken", name: "Kung Pao Chicken", time: "35 mins"),
            Dish(image: "dim_sum", name: "Dim Sum", time: "40 mins")
        ],
        "Fruits": [
            Dish(image: "apple", name: "Apple", time: "5 mins"),
            Dish(image: "banana", name: "Banana", time: "5 mins"),
            Dish(image: "orange", name: "Orange", time: "5 mins"),
            Dish(image: "grapes", name: "Grapes", time: "5 mins"),
            Dish(image: "watermelon", name: "Watermelon", time: "5 mins")
        ],
        "Vegetables": [
            Dish(image: "lady_finger", name: "Lady Finger", time: "10 mins"),
            Dish(image: "broccoli", name: "Broccoli", time: "15 mins"),
            Dish(image: "spinach", name: "Spinach", time: "10 mins"),
            Dish(image: "potato_cauliflower", name: "Potato, Cauliflower", time: "30 mins"),
            Dish(image: "pumpkin", name: "Pumpkin", time: "15 mins")
        ],
        "Protein": [
            Dish(image: "eggs", name: "Eggs", time: "10 mins"),
            Dish(image: "chicken_breast", name: "Chicken Breast", time: "30 mins"),
            Dish(image: "tofu", name: "Tofu", time: "15 mins"),
            Dish(image: "fish", name: "Fish", time: "25 mins"),
            Dish(image: "beans", name: "Beans", time: "20 mins")
        ]
    ]

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Color.gray.opacity(0.1)
                        .edgesIgnoringSafeArea(.all)
                                
                    if selectedTab == 0 {
                    // Show the main content of HomeView
                    VStack(spacing: 20) {
                        Spacer()
                        HeaderView(viewModel: viewModel)
                        SearchSection()
                        CategoryButtons(categories: categories, selectedCategory: $selectedCategory)
                        ScrollableDishesView(selectedCategory: selectedCategory, dishes: dishes)
                        NewRecipeView(selectedCategory: selectedCategory, dishes: dishes)
                    }
                    } else if selectedTab == 1 {
                        SavedItemsView()
                    } else if selectedTab == 2 {
                        NotificationsView()
                    } else if selectedTab == 3 {
                        ProfileView()
                    } else {
                        Text("View not found")
                    }
                }
                CustomTabBar(selectedTab: $selectedTab, tabbaritems: tabbaritems){
                    print("Plus Button tapped!")
                }
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    let tabbaritems: [TabBarItem]
    var onPlusButtonTap: (() -> Void)?

    var body: some View {
        ZStack {
            // Custom curved background for the tab bar
            CurvedTabBarShape()
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: -2)

            HStack(spacing: 0) { // No space between items to make them fill the width evenly
                ForEach(0..<tabbaritems.count, id: \.self) { index in
                    Button(action: {
                        selectedTab = index
                    }) {
                        VStack(spacing: 6) {
                            Image(systemName: tabbaritems[index].image)
                                .font(.system(size: 24))
                                .foregroundColor(selectedTab == index ? .green : .gray.opacity(0.6))

                            Text(tabbaritems[index].name)
                                .font(.caption)
                                .foregroundColor(selectedTab == index ? .green : .gray)
                        }
                        .frame(maxWidth: .infinity) // Distribute the items evenly across the width
                    }
                    .padding(.bottom, 20)
                }
            }
            .padding(.horizontal, 20)

            // Center Plus Button
            GeometryReader { geometry in
                Button(action: {
                    onPlusButtonTap?()
                }) {
                    ZStack {
                        Circle()
                            .foregroundColor(.green)
                            .frame(width: 70, height: 70) // Larger for floating effect
                            .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 4)

                        Image(systemName: "plus")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .position(x: geometry.size.width / 2, y: -5) // Position the button in the center
            }

            // Add padding on both sides of the Plus button by adjusting the position.
            .padding(.horizontal, 40) // Adjust to give more space on either side
        }
        .frame(width: UIScreen.main.bounds.width, height: 100) // Adjust height for the floating button
    }
}


// Custom shape for the curved tab bar
struct CurvedTabBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let curveHeight: CGFloat = 80 // Adjust curve depth
        let midX = rect.midX
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: midX - 50, y: 0))
        path.addQuadCurve(
            to: CGPoint(x: midX + 50, y: 0),
            control: CGPoint(x: midX, y: curveHeight)
        )
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        
        return path
    }
}

struct HeaderView: View {
    @ObservedObject var viewModel: ProfileViewViewModel
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Hello Folks.")
                    .font(.system(size: 22, weight: .bold))
                
                Text("What are you cooking today?")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Profile Image
            if let image = viewModel.profileImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.yellow.opacity(0.5))
            }
        }
        .padding([.horizontal, .top], 20)
        .onAppear {
            viewModel.loadImageFromDisk()
        }
    }
}

struct SearchSection: View {
    var body: some View {
        HStack(spacing: 20) {
            NavigationLink(destination: SearchRecipeView()) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.black.opacity(0.3))
                        .font(.system(size: 27))
                        .padding(.leading, 10)
                    
                    Text("Search recipe")
                        .font(.callout)
                        .foregroundColor(Color.black.opacity(0.3))
                        .padding(.leading, 5)
                    
                    Spacer()
                }
                .frame(height: 60)
                .padding(.horizontal, 10) // Inner padding
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.7), lineWidth: 1)
                )
            }
            
            Button(action: {
                // Add filter action here
            }) {
                Image(systemName: "slider.horizontal.3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                    .padding(10)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}

struct CategoryButtons: View {
    let categories: [String]
    @Binding var selectedCategory: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        selectedCategory = category
                    }) {
                        Text(category)
                            .font(.headline)
                            .padding(.horizontal, 20) // Make the buttons wider
                            .padding(.vertical, 12)
                            .background(
                                selectedCategory == category ? Color.green : Color.white
                            )
                            .foregroundColor(
                                selectedCategory == category ? Color.white : Color.green
                            )
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.top, 10)
    }
}


struct ScrollableDishesView: View {
    let selectedCategory: String
    let dishes: [String: [Dish]]

    var body: some View {
        VStack{
            ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                ForEach(dishes[selectedCategory] ?? [], id: \.id) { dish in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 150, height: 200)
                        
                        VStack(alignment: .center, spacing: 10) {
                            Image(dish.image)
                                .resizable()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                            
                            Text(dish.name)
                                .font(.headline)
                                .multilineTextAlignment(.center)
                            
                            Spacer()
                        }
                        .frame(width: 150, height: 200, alignment: .top)
                        .padding(.bottom, 25)
                        
                        VStack(alignment: .leading) {
                            Text(" ")
                             .padding(.top, 160)
                             .padding(.leading, 10)
                             .font(.footnote)
                             .foregroundColor(.black)
                         
                        HStack {
                            Text(dish.time)
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .padding([.leading, .bottom], 0)
                                .padding()
                            
                            Spacer()
                            
                            Button(action: {
                                // Your save action here
                            }) {
                                Image(systemName: "bookmark.fill")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.gray)
                                    .padding(8)
                                    .background(Circle().fill(Color.white))
                                    }
                                    .padding(.trailing, 10)
                                }
                                .padding(.bottom, 35)
                            }//save button end here
                        }
                    }
                }
                .padding(.horizontal, 25)
            }
        }
    }
}

struct NewRecipeView: View {
    @State private var newRecipeItems: [NewRecipe] = [
        NewRecipe(image: "Dosa", recipeName: "Dosa", time: "20 mins", rating: 5, chefName: "By Ayush Dev", chefImage: "AyushDev"),
        NewRecipe(image: "GriciaPasta", recipeName: "Gricia Pasta", time: "25 mins", rating: 5, chefName: "By Agni Kunj", chefImage: "AgniKunj"),
        NewRecipe(image: "GulabJamun", recipeName: "Gulab Jamun", time: "30 mins", rating: 5, chefName: "By Rajiv K", chefImage: "RajivK"),
        NewRecipe(image: "Idli", recipeName: "Idli", time: "25 mins", rating: 5, chefName: "By Krishnan Iyer", chefImage: "KrishnanIyer"),
        NewRecipe(image: "Vadapaw", recipeName: "Vadapaw", time: "20 mins", rating: 5, chefName: "By Rohit Khanna", chefImage: "RohitKhanna")
    ]
    
    let selectedCategory: String
    let dishes: [String: [Dish]]

    var body: some View {
        VStack {
            HStack {
                Text("New Recipes")
                    .font(.title2)
                    .bold()
                
                Spacer()
            }
            .padding(.horizontal, 30)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(newRecipeItems.indices, id: \.self) { index in
                        let dish = newRecipeItems[index]
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                                .frame(width: 280, height: 110)
                            
                            VStack(alignment: .center, spacing: 10) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(dish.recipeName)
                                            .font(.headline)
                                            .multilineTextAlignment(.leading)
                                        
                                        // Display 5-star rating
                                        HStack {
                                            ForEach(0..<5, id: \.self) { star in
                                                Image(systemName: star < dish.rating ? "star.fill" : "star")
                                                    .font(.system(size: 12))
                                                    .foregroundColor(star < dish.rating ? .yellow : .gray)
                                            }
                                        }
                                        .padding(.top, 3)
                                        .padding(.bottom, 6)
                                        HStack{
                                            Image(dish.chefImage)
                                                .resizable()
                                                .frame(width: 30, height: 30, alignment: .leading)
                                                .clipShape(Circle())
                                            
                                            Text(dish.chefName)
                                                .foregroundColor(Color.black.opacity(0.3))
                                                .font(.system(size: 15))
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    VStack{
                                        Image(dish.image)
                                            .resizable()
                                            .frame(width: 90, height: 90)
                                            .clipShape(Circle())
                                        
                                        HStack{
                                            Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                                                .resizable()
                                                .frame(width: 17, height: 17, alignment: .center)
                                                .foregroundColor(Color.black.opacity(0.3))
                                                .padding(.bottom, 30)
                                            
                                            Text(dish.time)
                                                .foregroundColor(Color.black.opacity(0.3))
                                                .padding(.bottom, 30)
                                                .font(.system(size: 15))
                                        }
                                    }
                                   
                                }
                            }
                            .frame(width: 240, height: 130)
                        }
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: ProfileViewViewModel())
    }
}
