pageextension 70111 "Purchase DA Agent Activities" extends "Purchase DA Agent Activities"
{
    layout
    {
        addafter("Pre-arrival Follow-up on Purchase Orders")
        {
            cuegroup("AnnutionTicket")
            {
                Caption = 'Annulatin de tickets';
                field(EnvoyEnAnnulation; rec.EnvoyEnAnnulation)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Visible = EnvoyEnAnnulations;
                    trigger OnDrillDown()
                    var
                        ItemWeignt: Record "Item Weigh Bridge";
                    begin
                        ItemWeignt.SetRange(Annule,ItemWeignt.Annule::"Envoyé en annulation");
                        if ItemWeignt.FindFirst() then begin
                            Page.Run(50208,ItemWeignt);
                        end;
                    end;
                }
                field(DemandeAutorisation; REC.DemandeAutorisation)
                {

                    ApplicationArea = All;
                    DrillDown = true;
                    Visible = DemandeAutorisations;
                    trigger OnDrillDown()
                    var
                        ItemWeignt: Record "Item Weigh Bridge";
                    begin
                        // ItemWeignt.SetRange(Annule,);
                    end;
                }
                field(TicketAAnnule; rec.TicketAAnnule)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Visible = TicketAAnnules;
                    trigger OnDrillDown()
                    begin
                    end;
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        usersetep: Record "User Setup";
    begin
        usersetep.SetRange("User ID", UserId);
        if usersetep.FindFirst() then begin
            if usersetep.Annule = usersetep.Annule::"Autorisation d'envoie" then begin
                EnvoyEnAnnulations := true;
            end;
            if usersetep.Annule = usersetep.Annule::"Accord d'autorisation d'annulation" then begin
                DemandeAutorisations := true;
            end;
            if usersetep.Annule = usersetep.Annule::"Autorisé à Annuler" then begin
                TicketAAnnules := true;
            end;
        end;
    end;

    var
        myInt: Integer;
        EnvoyEnAnnulations: Boolean;
        DemandeAutorisations: Boolean;
        TicketAAnnules: Boolean;

}