import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';

class BurgerCustomizationScreen extends StatefulWidget {
  static const routePath = "burger_customization";

  const BurgerCustomizationScreen({super.key});

  @override
  State<BurgerCustomizationScreen> createState() =>
      _BurgerCustomizationScreenState();
}

class _BurgerCustomizationScreenState extends State<BurgerCustomizationScreen> {
  List<String> ingredientAssets = [];
  bool isBurgerReady = false;

  void addIngredient(String imageAsset) {
    setState(() {
      ingredientAssets.add(imageAsset);
    });
  }

  void finishBurger() {
    setState(() {
      isBurgerReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF242329),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: finishBurger,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded button
                ),
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              child: Text('Finish Burger'),
            ),
          ),

          // Burger Display Section
          SizedBox(
            height: context.height * 0.6, // Adjusted height
            child: isBurgerReady
                ? Column(
                    children: [
                      Text(
                        "Yaaayyy !! Votre burger est prêt.",
                        style: TextStyle(color: Colors.green, fontSize: 24),
                      ),
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Burger bottom bun

                            // Stacked ingredients
                            for (int i = 0; i < ingredientAssets.length; i++)
                              Positioned(
                                bottom: 100 + (i * 10), // Adjust spacing
                                child: Image.asset(
                                  ingredientAssets[i],
                                  height: 60, // Adjust ingredient size
                                  width: 200,
                                ),
                              ),
                            // Burger top bun
                          ],
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    reverse: true, // Start from the bottom
                    itemCount: ingredientAssets.length,
                    itemBuilder: (context, index) {
                      String imageAsset = ingredientAssets[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Image.asset(
                          imageAsset,
                          height: 60,
                          width: 200,
                        ),
                      );
                    },
                  ),
          ),

          SizedBox(height: 20),

          // Ingredient Selection Section (Below the button)
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colours.lightThemeBlack1,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), // Rounded corners
                topRight: Radius.circular(30),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  // Ingredient buttons for adding items to the burger
                  _buildIngredientButton(Media.burgerMeat1, Media.burgerMeat1),
                  _buildIngredientButton(Media.burgerMeat2, Media.burgerMeat2),
                  _buildIngredientButton(Media.burgerMeat3, Media.burgerMeat3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to build ingredient buttons
  Widget _buildIngredientButton(String asset, String ingredient) {
    return GestureDetector(
      onTap: () => addIngredient(ingredient),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
        ),
        child: Image.asset(
          asset,
          height: 50,
          width: 140,
        ),
      ),
    );
  }
}
