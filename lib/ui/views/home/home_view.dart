import 'package:flutter/material.dart';
import 'package:report_generator/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'home_viewmodel.dart';

import 'package:flutter_quill/flutter_quill.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'increaseScale',
            key: const Key('increaseScale'),
            onPressed: viewModel.increaseScale,
            child: const Icon(Icons.add),
          ),
          verticalSpaceSmall,
          FloatingActionButton(
            heroTag: 'decreaseScale',
            key: const Key('decreaseScale'),
            onPressed: viewModel.decreaseScale,
            child: const Icon(Icons.remove),
          ),
        ],
      ),
      appBar: AppBar(
        toolbarHeight: viewModel.getAppBarHeight(context),
        title: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: QuillToolbar.simple(
            configurations: QuillSimpleToolbarConfigurations(
              showFontFamily: false,
              showInlineCode: false,
              showSubscript: false,
              showSuperscript: false,
              showBackgroundColorButton: false,
              showClearFormat: false,
              showListNumbers: false,
              showListBullets: false,
              showListCheck: false,
              showSearchButton: false,
              axis: Axis.horizontal,
              controller: viewModel.quillController,
              sharedConfigurations: const QuillSharedConfigurations(
                locale: Locale('es'),
              ),
              customButtons: [
                QuillToolbarCustomButtonOptions(
                  childBuilder: (options, extraOptions) {
                    return ElevatedButton(
                      onPressed: () {
                        // TODO: implement export
                      },
                      child: const Text('Exportar informe'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.black12,
            height: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.indigo.shade100,
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ETIQUETAS',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    verticalSpaceMedium,
                    const Text('Usuarios'),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.quillController.replaceText(
                          0,
                          0,
                          '[NOMBRE_USUARIO_DESDE_BASE_DE_DATOS]',
                          const TextSelection(
                            baseOffset: 1,
                            extentOffset: 2,
                          ),
                        );
                      },
                      child: const Text('Seleccionar usuario'),
                    ),
                    verticalSpaceMedium,
                    const Text('Plan de Acción'),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.quillController.replaceText(
                          viewModel.quillController.document.length - 1,
                          0,
                          '[PA]',
                          const TextSelection(
                            baseOffset: 10,
                            extentOffset: 20,
                          ),
                        );
                      },
                      child: const Text('PA'),
                    ),
                    verticalSpaceMedium,
                    const Text('Riesgos'),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.quillController.replaceText(
                          0,
                          0,
                          '[RR]',
                          const TextSelection(
                            baseOffset: 1,
                            extentOffset: 2,
                          ),
                        );
                      },
                      child: const Text('RR'),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Transform.scale(
                      scale: viewModel.scale,
                      child: Container(
                        height: MediaQuery.of(context).size.width * 1,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black.withOpacity(0.2),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(80 * viewModel.scale),
                        margin: EdgeInsets.all(40 * viewModel.scale),
                        child: QuillEditor.basic(
                          configurations: QuillEditorConfigurations(
                            controller: viewModel.quillController,
                            readOnly: false,
                            sharedConfigurations:
                                const QuillSharedConfigurations(
                              locale: Locale('es'),
                            ),
                            showCursor: true,
                            paintCursorAboveText: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
