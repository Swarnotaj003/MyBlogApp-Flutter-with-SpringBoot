import 'package:flutter/material.dart';
import 'package:my_blog_app/components/my_snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:my_blog_app/service/blog_post_provider.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  // Form elements
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String? _selectedTag;
  List<String> _images = [];

  @override
  void dispose() {
    _titleController.dispose();
    _imageController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _addImage() {
    final url = _imageController.text.trim();
    if (url.isNotEmpty) {
      setState(() {
        _images.add(url);
        _imageController.clear();
      });
    }
  }

  void _submitBlog() {
    if (_formKey.currentState!.validate()) {
      Provider.of<BlogPostProvider>(context, listen: false).addBlog(
        _titleController.text.trim(), _contentController.text, _selectedTag ?? '', _images
      );
      showMySnackBar(context, 'Blog posted successfully!', Colors.green);

      // clear the input fields
      _titleController.clear();
      _contentController.clear();
      setState(() {
        _selectedTag = null;
        _images = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Title',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.brown, width: 2.0),
                  ),
                  hintText: 'Enter post title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),

              // Image URL
              Text(
                'Image URL',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _imageController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.brown, width: 2.0),
                        ),
                        hintText: 'Enter image URL',
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _addImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Add', style: TextStyle(color: Colors.white, fontSize: 18,),),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Display added images
              if (_images.isNotEmpty)
                SizedBox(
                  height: 180, // fixed height to maintain aspect ratio
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      final url = _images[index];
                      return AspectRatio(
                        aspectRatio: 0.75,
                        child: Card(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                url,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _images.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: EdgeInsets.all(5),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              SizedBox(height: 15),

              // Content
              Text(
                'Content',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: _contentController,
                maxLines: 10,// fill available vertical space
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.brown, width: 2.0),
                  ),
                  hintText: 'Write your content here...',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Content cannot be empty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),

              // Tag Dropdown
              Text(
                'Tag',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 5),
              DropdownButtonFormField<String>(
                value: _selectedTag,
                items: Provider.of<BlogPostProvider>(context, listen: false).tags
                  .map((tag) => DropdownMenuItem(value: tag, child: Text(tag)),)
                  .toList(),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.brown, width: 2.0),
                  ),
                ),
                hint: Text('Select category/tag'),
                onChanged: (value) {
                  setState(() {
                    _selectedTag = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a tag';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: _submitBlog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Post Blog',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
