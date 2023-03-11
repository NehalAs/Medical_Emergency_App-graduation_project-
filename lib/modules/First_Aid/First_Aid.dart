import 'package:flutter/material.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/styles/colors.dart';

class Firstaid extends StatelessWidget {
  const Firstaid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 45.0,
            horizontal: 20.0,
          ),
          child:Expanded(

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.end,
              children:[
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color:Colors.red,
                        )),
                    const Text(
                      'الإسعافات الأولية للحروق',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),)
                  ],
                ),

                const Text('تعريف الحرق:',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('هو تلف في الأنسجة ناتج عن تعرض الجلد إلى الحرق بالنار أو التعرض بشكل مطول لأشعة الشمس أو أي إشعاع آخر، بالإضافة إلى ملامسة الأسطح الحارقة، أو المواد الكيميائية.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                myDevider(),
                Row(
                  children: [

                    Icon(
                      Icons.keyboard_double_arrow_down_sharp,
                      size: 40,
                      color: defaultColor,
                    ),
                    Spacer(),
                    const Text('حروق الدرجة الأولى :',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style:TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,

                      ) ,
                    ),
                  ],
                ),
                const Text('إجراءات إسعافية:',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),

                Row(
                  children: [

                    Icon(
                      Icons.label_important_outlined,
                      size: 40,
                      color: defaultColor,
                    ),
                    Icon(
                      Icons.label_important_outlined,
                      size: 40,
                      color: defaultColor,
                    ),
                    Spacer(),
                    const Text('افعل (√):',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style:TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,

                      ) ,
                    ),
                  ],
                ),


                const Text('تبريد الحرق للمساعدة في تهدئة الألم وذلك بوضع المنطقة المحترقة تحت الماء الجاري من الصنبور والمعتدل البرودة لمدة 10 إلى 15 دقيقة لتخفف الألم.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('إزالة الاكسسوارات (مثل: خواتم أو ساعات أو أحزمة ) إن وجدت أو إزالة أحذية أو أي ملابس برفق وبسرعة ، قبل أن تتضخم المنطقة.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('تغطية منطقة الحرق باستخدام ضمادة رطبة أو قطعة قماش نظيفة باردة، لتقليل خطر العدوى.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('أخذ مسكن الألم إذا لزم الأمر وذلك لتخفيف الألم.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('اطلب المساعدة فورًا إذا كانت الحروق شديدة وتمتد لمساحات واسعة، أو إذا لاحظت علامات العدوى مثل زيادة الألم واحمرار وتورم.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Row(
                  children: [

                    Icon(
                      Icons.label_important_outline,
                      size: 40,
                      color: defaultColor,
                    ),
                    Icon(
                      Icons.label_important_outline,
                      size: 40,
                      color: defaultColor,
                    ),
                    Spacer(),
                    const Text('لا تفعل (X):',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style:TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,

                      ) ,
                    ),
                  ],
                ),


                const Text('لا تضع أي مراهم أو استخدام الزبدة أو معجون الأسنان وغيرها من العلاجات على الحرق.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('لا تستخدم الثلج مباشرة على المنطقة المصابة بالحروق.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                myDevider(),
                //  الدرجة الثانية
                Row(
                  children: [

                    Icon(
                      Icons.keyboard_double_arrow_down_sharp,
                      size: 40,
                      color: defaultColor,
                    ),
                    Spacer(),
                    const Text('حروق الدرجة الثانية:',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style:TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,

                      ) ,
                    ),
                  ],
                ),

                const Text('إجراءات إسعافية:',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),

                Row(
                  children: [

                    Icon(
                      Icons.label_important_outlined,
                      size: 40,
                      color: defaultColor,
                    ),
                    Icon(
                      Icons.label_important_outlined,
                      size: 40,
                      color: defaultColor,
                    ),
                    Spacer(),
                    const Text('افعل (√):',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style:TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,

                      ) ,
                    ),
                  ],
                ),

                const Text('حماية الشخص المصاب من الضرر.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(

                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('انزع المجوهرات والأحزمة وغيرها، خاصة حول المناطق المحترقة على سبيل المثال الرقبة.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('أخذ مسكن الألم إذا لزم الأمر وذلك لتخفيف الألم.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('تغطية منطقة الحرق باستخدام ضمادة رطبة أو قطعة قماش نظيفة باردة.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('تغطية الفقاعات المفتوحة بضمادة جافة ومعقمة.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                myDevider(),
                Row(
                  children: [

                    Icon(
                      Icons.label_important_outline,
                      size: 40,
                      color: defaultColor,
                    ),
                    Icon(
                      Icons.label_important_outline,
                      size: 40,
                      color: defaultColor,
                    ),
                    Spacer(),
                    const Text('لا تفعل (X):',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style:TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,

                      ) ,
                    ),
                  ],
                ),

                const Text('إزالة الملابس المحترقة العالقة على الجلد.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('تغطية الحرق بضمادة لاصقة.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('وضع المناطق المصابة بالحروق الكبيرة داخل الماء البارد لتفادي حدوث صدمة للمصاب.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('استخدام الثلج مباشرة على المنطقة المصابة بالحروق.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('وضع أي مراهم أو استخدام الزبدة أو معجون الأسنان، أو غيرها من العلاجات على الحرق.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('لمس أو فتح الفقاعات الناتجة من الحرق.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('وضع القطن الرقيق على المنطقة المصابة والذي قد يثير الجلد.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                // الدرجة الثالثة
                myDevider(),
                Row(
                  children: [

                    Icon(
                      Icons.keyboard_double_arrow_down_sharp,
                      size: 40,
                      color: defaultColor,
                    ),
                    Spacer(),
                    const Text('حروق الدرجة الثالثة :',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style:TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,

                      ) ,
                    ),
                  ],
                ),

                const Text('تعتبر من أخطر الحروق حيث تشمل جميع طبقات الجلد وصولًا إلى الدهون، وقد تتأثر العضلات.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('إجراءات إسعافية:',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),

                Row(
                  children: [

                    Icon(
                      Icons.label_important_outlined,
                      size: 40,
                      color: defaultColor,
                    ),
                    Icon(
                      Icons.label_important_outlined,
                      size: 40,
                      color: defaultColor,
                    ),
                    Spacer(),
                    const Text('افعل (√):',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style:TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,

                      ) ,
                    ),
                  ],
                ),

                const Text('الاتصال بالهلال الأحمر فورًا، واتخاذ الإجراءات التاليه لحين وصولها',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('تأكد من العلامات الحيوية للمصاب مثل التنفس.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('حماية الشخص المصاب من الضرر، وذلك بإبعاده عن المواد المشتعلة أو الدخان أو مصادر الحرارة.',

                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('رفع المنطقة المصابة فوق مستوى القلب إذا كان ذلك ممكنا.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('تغطية منطقة الحرق باستخدام ضمادة رطبة أو قطعة قماش نظيفة باردة.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Row(
                  children: [

                    Icon(
                      Icons.label_important_outline,
                      size: 40,
                      color: defaultColor,
                    ),
                    Icon(
                      Icons.label_important_outline,
                      size: 40,
                      color: defaultColor,
                    ),
                    Spacer(),
                    const Text('لا تفعل (X):',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style:TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,

                      ) ,
                    ),
                  ],
                ),


                const Text('إزالة الملابس المحترقة العالقة على الجلد.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('وضع المناطق المصابة بالحروق الكبيرة داخل الماء البارد لتفادي حدوث صدمة للمصاب (انخفاض مفاجئ في درجة حرارة الجسم).',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('تغطية الحرق بضمادة لاصقة.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('وضع أي مراهم أو استخدام الزبدة أو معجون الأسنان، أو غيرها من العلاجات على الحرق.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                const Text('وضع القطن الرقيق على المنطقة المصابة والذي قد يثير المنطقة المصابة',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),

              ],

            ),
          ),
        ),


      ),

    );
  }
}
