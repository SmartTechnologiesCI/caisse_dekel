pageextension 70110 "New Ticket" extends "New Ticket"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(Validation)
        {
            action(DemanderAnnulation)
            {
                Caption = 'Envoyer en annulation';
                trigger OnAction()
                begin

                end;
            }
            action(AutorisationAnnulation)
            {
                Caption = 'Autoriser annulation';
                trigger OnAction()
                begin

                end;
            }
            action(Annuler)
            {
                Caption = 'Annuler';
                trigger OnAction()
                begin

                end;
            }
        }

    }

    var
        myInt: Integer;
}