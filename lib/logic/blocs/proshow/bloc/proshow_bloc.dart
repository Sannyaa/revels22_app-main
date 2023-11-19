import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/models/proshow_model.dart';

part 'proshow_event.dart';
part 'proshow_state.dart';

class ProshowBloc extends Bloc<ProshowEvent, ProshowState> {
  ProshowBloc() : super(ProshowLoading()) {
    on<ProshowInit>((event, emit) async{
    await  Future.delayed(Duration(seconds: 2));
      List<Proshow> data = [
        Proshow(name:"Dua and Suri", id:"1", url:"https://www.instagram.com/p/B-wBm7THtMe/media/?size=l",free:true),
        Proshow(name:"Zaden", id:"2", url:"https://www.instagram.com/p/B-wB52yH8Pv/media/?size=l",free:false),
        Proshow(name:"Prateek Kuhad", id:"3", url:"https://www.instagram.com/p/B-wB27hHSGX/media/?size=l",free:false),
        Proshow(name:"Teri Miko", id:"4", url:"https://www.instagram.com/p/B-wByzaHsUh/media/?size=l",free:false),
      ];
      emit(ProshowLoaded(data : data));
    });
  }
}
