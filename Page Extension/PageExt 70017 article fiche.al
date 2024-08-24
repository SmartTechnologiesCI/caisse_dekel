pageextension 70017 ArticleFiche extends "Item Card"
{
    layout
    {
        modify("Item Category Code")
        {
            ShowMandatory = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        myInt: Integer;
    begin
        if rec."No." <> '' then begin
            if rec."Item Category Code" = '' then
                Error('Veuillez définir la catégorie de l''article.');
        end;
    end;
}