pageextension 70110 "New Ticket" extends "New Ticket"
{
    layout
    {
        addafter("Process Ticket")
        {
            field(Annule; REC.Annule)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

    actions
    {
        addafter(Validation)
        {
            action(Envoie)
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Caption = 'Demander une annulation';
                Visible = AnnuleDemande;

                trigger OnAction()
                var
                    UserSetep: Record "User Setup";
                    UserSetep2: Record "User Setup";
                begin
                    rec.TestField(Annule, Rec.Annule::" ");
                    REC.Annule := rec.Annule::"Envoyé en annulation";
                    rec."Envoyé en annulation" := true;
                    rec.Modify();
                    Message('Demande envoyé avec succès');
                end;
            }
            action(AutorisationAnnulation)
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Visible = AnnuleAutorisation;
                Caption = 'Autoriser l''annulation';
                trigger OnAction()
                begin
                    REC.TestField(Annule, rec.Annule::"Envoyé en annulation");
                    REC.Annule := rec.Annule::"Autorisé à être annulé";
                    REC."Autorisé à être annulé" := true;
                    rec.Modify();
                    Message('Autorisation accordée avec succès');
                end;
            }
            action(AnnulerTicket)
            {
                Caption = 'Aannuler le ticket(Non Payé)';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Visible = AnnulationAnnuler;
                trigger OnAction()
                begin
                    rec.TestField(Annule, rec.Annule::"Autorisé à être annulé");
                    rec.Annule := rec.Annule::"Annulé";
                    rec.TicketAnnule := true;
                    rec.Modify();
                    Message('Annulation effectuée avec succès');
                end;
            }
        }

    }
    trigger OnOpenPage()
    var
        myInt: Integer;
        UserSetep: Record "User Setup";
    begin
        Clear(AnnulationAnnuler);
        Clear(AnnuleDemande);
        Clear(AnnuleAutorisation);
        UserSetep.SetRange("User ID", UserId);
        if UserSetep.FindFirst() then begin
            if UserSetep.Annule = UserSetep.Annule::"Autorisation d'envoie" then begin
                AnnuleDemande := true;
            end;
            if UserSetep.Annule = UserSetep.Annule::"Accord d'autorisation d'annulation" then begin

                AnnuleAutorisation := true;
            end;
            if UserSetep.Annule = UserSetep.Annule::"Autorisé à Annuler" then begin

                AnnulationAnnuler := true;

            end;
        end;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        myInt: Integer;
        ItemWeight: Record "Item Weigh Bridge";
        NoSeries: Record "No. Series Line";
        Balance: Record Balance;


    begin
        /******FnGeek 10_02_26
        if rec."POIDS ENTREE" = 0 then begin
            Balance.SetRange(Code, rec."Balance Code");
            if Balance.FindFirst() then begin
                NoSeries.SetRange("Series Code", Balance."Souche N°");
                if NoSeries.FindFirst() then begin
                    if rec."Ticket Planteur" <> '' then begin
                        ItemWeight.SetFilter(RacineBalance, '=%1', CopyStr(rec."Ticket Planteur", 1, 2));
                        if ItemWeight.FindLast() then begin
                            NoSeries."Last No. Used" := ItemWeight."Ticket Planteur";
                            NoSeries.Modify();
                        end;
                    end;
                end;
            end;

        end;
        */
    end;

    var
        myInt: Integer;
        //Annulation de ticket
        AnnuleDemande: Boolean;
        AnnuleAutorisation: Boolean;
        AnnulationAnnuler: Boolean;
}