import 'package:flutter/material.dart';

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
              children:  const [
                Text('الإسعافات الأولية للحروق',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(

                    color: Colors.red,
                    decoration: TextDecoration.underline,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ) ,
                ),

                Text('تعريف الحرق:',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('هو تلف في الأنسجة ناتج عن تعرض الجلد إلى الحرق بالنار أو التعرض بشكل مطول لأشعة الشمس أو أي إشعاع آخر، بالإضافة إلى ملامسة الأسطح الحارقة، أو المواد الكيميائية.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('حروق الدرجة الأولى (الخفيفة):',

                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('إجراءات إسعافية:',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('افعل (√):',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('تبريد الحرق للمساعدة في تهدئة الألم وذلك بوضع المنطقة المحترقة تحت الماء الجاري من الصنبور والمعتدل البرودة لمدة 10 إلى 15 دقيقة لتخفف الألم.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('إزالة الاكسسوارات (مثل: خواتم أو ساعات أو أحزمة ) إن وجدت أو إزالة أحذية أو أي ملابس برفق وبسرعة ، قبل أن تتضخم المنطقة.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('تغطية منطقة الحرق باستخدام ضمادة رطبة أو قطعة قماش نظيفة باردة، لتقليل خطر العدوى.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('أخذ مسكن الألم إذا لزم الأمر وذلك لتخفيف الألم.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('اطلب المساعدة فورًا إذا كانت الحروق شديدة وتمتد لمساحات واسعة، أو إذا لاحظت علامات العدوى مثل زيادة الألم واحمرار وتورم.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('لا تفعل (X):',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),

                Text('لا تضع أي مراهم أو استخدام الزبدة أو معجون الأسنان وغيرها من العلاجات على الحرق.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('لا تستخدم الثلج مباشرة على المنطقة المصابة بالحروق.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),

                // الدرجة الثانية
                Text('حروق الدرجة الثانية:',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('إجراءات إسعافية:',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('افعل (√):',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('حماية الشخص المصاب من الضرر.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(

                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('انزع المجوهرات والأحزمة وغيرها، خاصة حول المناطق المحترقة على سبيل المثال الرقبة.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('أخذ مسكن الألم إذا لزم الأمر وذلك لتخفيف الألم.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('تغطية منطقة الحرق باستخدام ضمادة رطبة أو قطعة قماش نظيفة باردة.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('تغطية الفقاعات المفتوحة بضمادة جافة ومعقمة.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('لا تفعل (X):',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('إزالة الملابس المحترقة العالقة على الجلد.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('تغطية الحرق بضمادة لاصقة.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('وضع المناطق المصابة بالحروق الكبيرة داخل الماء البارد لتفادي حدوث صدمة للمصاب.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('استخدام الثلج مباشرة على المنطقة المصابة بالحروق.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('وضع أي مراهم أو استخدام الزبدة أو معجون الأسنان، أو غيرها من العلاجات على الحرق.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('لمس أو فتح الفقاعات الناتجة من الحرق.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('وضع القطن الرقيق على المنطقة المصابة والذي قد يثير الجلد.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                // الدرجة الثالثة


                Text('حروق الدرجة الثالثة :',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('تعتبر من أخطر الحروق حيث تشمل جميع طبقات الجلد وصولًا إلى الدهون، وقد تتأثر العضلات.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('إجراءات إسعافية:',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('افعل (√):',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('الاتصال بالهلال الأحمر فورًا، واتخاذ الإجراءات التاليه لحين وصولها',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('تأكد من العلامات الحيوية للمصاب مثل التنفس.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('حماية الشخص المصاب من الضرر، وذلك بإبعاده عن المواد المشتعلة أو الدخان أو مصادر الحرارة.',

                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('رفع المنطقة المصابة فوق مستوى القلب إذا كان ذلك ممكنا.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('تغطية منطقة الحرق باستخدام ضمادة رطبة أو قطعة قماش نظيفة باردة.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('لا تفعل (X):',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('إزالة الملابس المحترقة العالقة على الجلد.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('وضع المناطق المصابة بالحروق الكبيرة داخل الماء البارد لتفادي حدوث صدمة للمصاب (انخفاض مفاجئ في درجة حرارة الجسم).',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('تغطية الحرق بضمادة لاصقة.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('وضع أي مراهم أو استخدام الزبدة أو معجون الأسنان، أو غيرها من العلاجات على الحرق.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ) ,
                ),
                Text('وضع القطن الرقيق على المنطقة المصابة والذي قد يثير المنطقة المصابة',
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
