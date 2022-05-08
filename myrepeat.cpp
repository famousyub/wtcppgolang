#include <Wt/WApplication.h>
#include <Wt/WBreak.h>
#include <Wt/WContainerWidget.h>
#include <Wt/WLineEdit.h>
#include <Wt/WText.h>

using namespace std;
using namespace Wt;

// définit une application Web
struct App : WApplication {
  App(const WEnvironment& env) : WApplication(env) {

    // ajoute des widgets
    auto myEdit = root()->addWidget(make_unique<WLineEdit>());
    root()->addWidget(make_unique<WBreak>());
    auto myText = root()->addWidget(make_unique<WText>());

    // connecte les widgets aux fonctions de rappel
    auto editFunc = [=]{ myText->setText(myEdit->text()); };
    myEdit->textInput().connect(editFunc);
  }
};

// lance l’application Web
int main(int argc, char **argv) {
  auto mkApp = [](const WEnvironment& env) { return make_unique<App>(env); };
  return WRun(argc, argv, mkApp);
}