import '../../../../commons/models/dynamic_field_model.dart';

class ListUserDynamicFieldsUsecase {
  ListUserDynamicFieldsUsecase();

  List<DynamicFieldModel> call() => [
        DynamicFieldModel(
          code: 'name',
          label: 'Nome',
          placeholder: 'Digite o nome',
        ),
      ];
}
