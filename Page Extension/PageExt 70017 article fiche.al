pageextension 70017 ArticleFiche extends "Item Card"
{
    layout
    {
        modify("Item Category Code")
        {
            ShowMandatory = true;
        }
        addafter(GTIN)
        {
            field(CL; rec.CL)
            {
                ApplicationArea = All;
                trigger OnLookUp(var Text: Text): Boolean
                var
                    //GroupUser: Record "General Settings";
                    GroupUser: Record MagasinCentreLogistique;
                begin
                    // GroupUser.Reset();
                    // // GroupUser.SetRange(Type, GroupUser.Type::Site);
                    // //  GroupUser.SetRange(Type, GroupUser.Type::Site);
                    // IF PAGE.RUNMODAL(60205, GroupUser) = ACTION::LookupOK THEN BEGIN
                    //     Text := GroupUser."User Group Code";

                    //     IF rec."Filtres groupes utilisateurs" <> '' THEN begin
                    //         // REC."Filtres groupes utilisateurs" += '|' + GroupUser."Groupe utilisateur"
                    //         REC."Filtres groupes utilisateurs" += '|' + GroupUser."User Group Code"
                    //     end
                    //     ELSE begin
                    //         // REC."Filtres groupes utilisateurs" := GroupUser."Groupe utilisateur";
                    //         REC."Filtres groupes utilisateurs" := GroupUser."User Group Code";
                    //     end;
                    //     Text := REC."Filtres groupes utilisateurs";
                    //     EXIT(TRUE);
                    // end;
                    GroupUser.Reset();
                    // GroupUser.SetRange(Type, GroupUser.Type::Site);
                    //  GroupUser.SetRange(Type, GroupUser.Type::Site);
                    IF PAGE.RUNMODAL(Page::listeMagasinCentreLogistique, GroupUser) = ACTION::LookupOK THEN BEGIN
                        Text := GroupUser.Description;

                        IF rec.CL <> '' THEN begin
                            // REC."Filtres groupes utilisateurs" += '|' + GroupUser."Groupe utilisateur"
                            // REC."User Group Filters" += '|' + GroupUser."User Group Code"//FnGeek 02_07_25 commented to this day
                            REC.cl += '|' + GroupUser.Description
                        end
                        ELSE begin
                            // REC."Filtres groupes utilisateurs" := GroupUser."Groupe utilisateur";
                            REC.CL := GroupUser.Description;
                        end;
                        Text := REC.CL;
                        EXIT(TRUE);
                    end;
                END;
            }
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
        // if rec."No." <> '' then begin
        //     if rec."Item Category Code" = '' then
        //         Error('Veuillez définir la catégorie de l''article.');
        // end;
    end;
}