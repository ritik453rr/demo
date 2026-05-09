import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DragSheetPage extends StatefulWidget {
  const DragSheetPage({super.key});

  @override
  State<DragSheetPage> createState() => _DragSheetPageState();
}

class _DragSheetPageState extends State<DragSheetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DraggableScrollableSheet(
        	initialChildSize: 0.68,
        	minChildSize: 0.67,
        	maxChildSize: 0.82,
        	builder: (BuildContext context, ScrollController scrollController) {
          	return Container(
            	padding: EdgeInsets.symmetric(horizontal: 20),
            	decoration: BoxDecoration(
              	color: Colors.white,
              	borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            	),
            	child: CustomScrollView(
              	controller: scrollController,
              	physics: ClampingScrollPhysics(),
              	slivers: [
                	SliverToBoxAdapter(child: SizedBox(height: 20)),
                	SliverToBoxAdapter(
                  	child: Center(
                    	child: Text(
                      	"Product Name"
                    	),
                  	),
                	),
                	SliverToBoxAdapter(child: SizedBox(height: 24)),
                	SliverToBoxAdapter(
                  	child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.red,
                    )
                	),
                	SliverToBoxAdapter(child: SizedBox(height: 24)),
                	SliverToBoxAdapter(
                  	child: Container(
                      color: Colors.yellow,
                      height: 100,
                      width: 100,
                    )
                	),
                	SliverToBoxAdapter(child: SizedBox(height: 24)),
                	SliverToBoxAdapter(
                  	child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.red,
                    )
                	),
              
              	],
            	),
          	);
        	},
      	),

          ],
        ),
      ),
    ); 
  }
}