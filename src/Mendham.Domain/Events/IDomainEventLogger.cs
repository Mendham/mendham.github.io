﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Mendham.Domain.Events
{
	/// <summary>
	/// Use this interface for any logger that should log when any domain event is raised
	/// </summary>
	public interface IDomainEventLogger
	{
		/// <summary>
		/// Logs Domain Event
		/// </summary>
		/// <typeparam name="TDomainEvent">Type of domain event</typeparam>
		/// <param name="domainEvent">Domain Event</param>
		void LogDomainEvent<TDomainEvent>(TDomainEvent domainEvent) where TDomainEvent : IDomainEvent;
	}
}